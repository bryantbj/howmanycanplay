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
      <div class="card">
        <div class="card-body">
        <div class="card-title">
          <h1 class="card-title mb-0 uppercase tracking-widest"><%= @game.name %></h1>
          <h6 class="text-sm font-normal lowercase text-opacity-50"><%= @game.genres ++ @game.game_modes |> Enum.join(", ") %></h6>
        </div>
          <h2 class="card-title mt-3 mb-3">How many can play</h2>
          <%= mode_counts(%{game: @game}) %>
          <h2 class="card-title mt-3">Summary</h2>
          <p class="leading-relaxed"><%= @game.summary %></p>
        </div>
      </div>
      <pre><code class="max-w-prose mt-3 overflow-x"><%= Jason.encode!(@game) |> Jason.Formatter.pretty_print() %></code></pre>
    </div>
    """
  end

  def mode_counts(assigns) do
    ~H"""
    <div class="flex">
    <%= case @game.multiplayer_modes do %>
      <% [] -> %><span class="badge">data missing</span>
      <% modes -> %>
      <%= for mode <- modes do %>
          <div class="badge p-1 px-2 mr-2">
          <%= if platform = get_in(mode, [:platform, :abbreviation]) do %>
          <span class="text-gray-500 "><%= platform %></span>&nbsp;
          <% end %>
          <%= Map.get(mode, :onlinecoopmax, "?") %>
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
