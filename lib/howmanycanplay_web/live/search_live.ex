defmodule HowmanycanplayWeb.SearchLive do
  use HowmanycanplayWeb, :live_view

  def mount(params, _session, socket) do
    # socket = assign(socket, key: value)
    tz = Map.get(params, "tz", "America/Chicago")
    q = Map.get(params, "q", nil)

    if q do
      send(self(), {:run_game_search, q})
    end

    socket =
      socket
      |> assign(params: Map.take(params, ~w[q]))
      |> assign(tz: tz)
      |> assign(games: [])
      |> assign(loading: false)
      |> assign(q: "")

    {:ok, socket, temporary_assigns: [games: []]}
  end

  def render(assigns) do
    ~H"""
    <div class="wrapper">
      <div class="card">
        <div class="card-body">
          <h1 class="card-title text-right uppercase tracking-widest">How many can play...</h1>
          <form phx-submit="search">
            <div class="relative form-control">
              <label class="input-group">
                <span class="bg-opacity-70 border border-base-content/40 border-r-0"><i class="fas fa-search"></i></span>
                <input class="border-l-0 focus:border-0 shadow-lg focus:shadow-2xl input input-bordered input-lg focus:input-accent w-full bg-transparent" type="text" name="q" autocomplete="off" spellcheck="off" value={@q} autofocus/>
                <%= if @loading do %>
                <div class="h-full flex items-center absolute right-6 top-0">
                  <i class="fas fa-circle-notch rotate-center text-secondary"></i>
                </div>
                <% end %>
              </label>
            </div>
          </form>

          <%= if String.length(@q) > 0 && (not @loading) do %>
            <div class="mt-3">
            <%= if Enum.any?(@games) do %>
              <%= game_list(%{games: @games, socket: @socket}) %>
            <% else %>
              No results found for "<%= @q %>"
            <% end %>
            </div>
          <% end %>
        </div>
      </div>
      <%= if Mix.env == :dev do %>
      <code class="max-w-screen overflow-x">
      <%= Jason.encode!(@games) %>
      </code>
      <% end %>
    </div>
    """
  end

  def game_list(assigns) do
    ~H"""
    <ul class="menu">
      <%= for game <- @games do %>
        <li class="hover:underline flex flex-row align-baseline">
        <%= live_patch(to: Routes.live_path(@socket, HowmanycanplayWeb.GameLive, %{id: game.id})) do %>
          <%= game_li_text(%{game: game}) %>

          <%= if Enum.any?(game.release_dates) do %>
            <% min_date = Enum.min_by(game.release_dates, & &1[:year]).year %>
          <% end %>
        <% end %>
        </li>
      <% end %>
    </ul>
    """
  end

  def game_li_text(%{game: %{onlinecoopmax: max, year_released: year} = game} = assigns) do
    ~H"""
    <%= String.trim(@game.name) %>
    <%= case year do %>
      <% x when is_integer(x) and x > 0 -> %>&nbsp;(<%= x %>)
      <% _ -> %><%= "" %>
    <% end %>
    <%= case max do %>
      <% x when is_integer(x) and x > 0 -> %>&nbsp;<span class="text-accent"><%= x %></span>
      <% _ -> %><%= "" %>
    <% end %>
    """
  end

  def handle_params(%{"q" => q} = params, _uri, socket) do
    send(self(), {:run_game_search, q})

    socket =
      socket
      |> assign(q: q)
      |> assign(games: [])
      |> assign(loading: true)
      |> assign(params: params)

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def self_path(socket, extra) do
    Routes.live_path(socket, __MODULE__, Enum.into(extra, socket.assigns.params))
  end

  def handle_event("search", %{"q" => q}, socket) do
    socket = assign(socket, q: q, games: [], loading: true)

    {:noreply, push_patch(socket, to: self_path(socket, q: q))}
  end

  def handle_info({:run_game_search, query}, socket) do
    socket =
      case Igdb.search(query, limit: 10) do
        {:error, error} ->
          socket
          |> put_flash(:error, "An error occurred. Try again. Error message: #{error}")
          |> assign(loading: false)

        {_, games} ->
          games =
            Enum.sort_by(games, & {&1.onlinecoopmax, &1.follows}, :desc)

          socket
          |> assign(q: query, loading: false, games: games)
      end

    {:noreply, socket}
  end
end
