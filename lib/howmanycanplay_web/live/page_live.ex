defmodule HowmanycanplayWeb.PageLive do
  use HowmanycanplayWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{}, selected: [])}
  end

  def handle_event("submit", _params, socket), do: {:noreply, socket}

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply,
     assign(socket, results: search(query), query: query, selected: socket.assigns.selected)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query, selected: socket.assigns.selected)}
    end
  end

  def handle_event("select", %{"id" => id}, socket) do
    game = Howmanycanplay.Games.get_game!(id)
    selected = Enum.uniq_by([game], & &1.id)

    game
    |> IO.inspect(label: "game")

    {:noreply,
     socket
     |> assign(results: socket.assigns.results, query: socket.assigns.query, selected: selected)}
  end

  defp search(query) do
    if not HowmanycanplayWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    case String.length(query) do
      0 ->
        %{}

      _ ->
        result =
          Howmanycanplay.Games.Game
          |> Howmanycanplay.Games.search_games(query)
          |> IO.inspect(label: "search result")

        # (result && %{1 => result}) || %{1 => "No game found for search \"#{query}\""}
        result || %{1 => "No game found for search \"#{query}\""}
    end

    # for {app, desc, vsn} <- Application.started_applications(),
    #     app = to_string(app),
    #     String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
    #     into: %{},
    #     do: {app, vsn}
  end

  defp games do
    [
      "Destiny 2",
      "Overwatch",
      "Guild Wars 2",
      "Call of Duty: Modern Warfare"
    ]
  end
end
