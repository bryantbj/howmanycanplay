defmodule HowmanycanplayWeb.GameLive do
  use HowmanycanplayWeb, :live_view

  def mount(%{"id" => id}, _session, socket) do
    game =
      case Igdb.fetch_game(id) do
        {:ok, game} ->
          game

        other ->
          other
      end

    socket =
      socket
      |> assign(:game, game)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="wrapper">
      <div class="card game-card ">
        <figure>
          <img loading="lazy" src={@game.cover_url} />
        </figure>
        <div class="card-body">
        <div class="card-title">
          <h1 class="card-title mb-0 uppercase tracking-widest"><%= @game.name %></h1>
          <h6 class="text-sm font-normal lowercase text-opacity-50"><%= @game.genres ++ @game.game_modes |> Enum.join(", ") %></h6>
        </div>
          <h2 class="card-title mt-3 mb-3">How many can play</h2>
          <%= mode_counts(%{game: @game}) %>
          <h2 class="card-title mt-3">Summary</h2>
          <p class="leading-relaxed"><%= @game.summary %></p>

          <div class="card-actions justify-end">
            <h6 class="text-sm font-normal uppercase text-opacity-50">
              <%= if Enum.any?(@game.platforms) do %>
                <%= for platform <- @game.platforms do %>
                <span class="badge p-1 px-2 mr-2 shadow-lg"><%= platform[:abbreviation] %></span>
                <% end %>
              <% end %>
            </h6>
          </div>
        </div>

      </div>
      <%= if Mix.env == :dev do %>
      <pre><code class="max-w-prose mt-3 overflow-x"><%= Jason.encode!(@game) |> Jason.Formatter.pretty_print() %></code></pre>
      <% end %>
    </div>
    """
  end

  def mode_counts(%{game: game} = assigns) do
    single = Enum.empty?(game.multiplayer_modes) and "Single player" in game.game_modes

    ~H"""
    <div class="flex">
    <%= case @game.multiplayer_modes do %>
      <% [] -> %><span class="badge text-accent shadow-lg"><%= single and 1 || "data missing" %></span>
      <% modes -> %>
      <%= for mode <- modes do %>
          <div class="badge p-1 px-2 mr-2">
          <%= if platform = get_in(mode, [:platform, :abbreviation]) do %>
          <span class=""><%= platform %></span>&nbsp;
          <% end %>
          <span class="text-accent font-medium shadow-lg"><%= Map.get(mode, :onlinecoopmax, "data missing") %></span>
        </div>
      <% end %>
    <% end %>
    </div>
    """
  end

  # def handle_event(message, _, socket) do
  # socket = assign(socket, key: value)
  # {:noreply, socket}
  # end

  # def handle_info(message, socket) do
  # socket = assign(socket, key: value)
  # {:noreply, socket}
  # end
end
