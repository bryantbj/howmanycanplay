defmodule Igdb do
  use HTTPoison.Base
  import Twitch, only: [client_id: 0, token: 0]
  alias Howmanycanplay.Game

  @endpoint "https://api.igdb.com/v4"

  def process_url(url), do: @endpoint <> url

  def process_response_body(body) when is_list(body) do
    Enum.map(body, &process_request_body/1)
  end

  def process_response_body(map) when is_map(map) do
    for {k, v} <- map,
        into: %{} do
      {String.to_atom(k), v}
    end
  end

  def process_response_body(binary) when is_binary(binary) do
    binary
    |> Jason.decode(keys: :atoms)
    |> case do
      {:ok, body} ->
        body

      {:error, error} ->
        error
    end
  end

  def auth_headers() do
    [
      "Client-ID": client_id(),
      Authorization: "Bearer " <> token()
    ]
  end

  def process_request_headers(headers) when is_map(headers) do
    headers
    |> Enum.into([])
    |> Keyword.merge(auth_headers())
  end

  def process_request_headers(headers) when is_list(headers) do
    headers
    |> Keyword.merge(auth_headers())
  end

  @doc """
  Search IGDB games for a given phrase.

  ## opts
  limit: Integer 25 (default), 500 (max)
  """
  def search(keyword, opts \\ []) do
    defaults = [limit: 25]
    keyword = String.trim(keyword)
    # -- cache
    # key = "search/#{keyword}"

    # Cachex.fetch(:igdb, key, fn ->
    #   %{body: resp} = post!("/games", search_game_query(keyword, Keyword.merge(defaults, opts)))
    #   {:commit, resp}
    # end)
    # |> IO.inspect(label: "search")
    # -- /cache

    case post("/games", search_game_query(keyword, Keyword.merge(defaults, opts))) do
      {:ok, %{body: resp}} ->
        {:ok, Enum.map(resp, &Game.new/1)}

      {:error, _} ->
        {:error, "idk"}
    end
  end

  def fetch_game(id, cache \\ false) do
    key = "game/#{id}"

    game_resp =
      if cache do
        fetch_and_cache(key, game_api_fun(id))
      else
        game_api(id)
      end

    with {:ok, %{body: resp}} <- game_resp,
         [%{result: [game]}] <- resp do
      {:ok, Game.new(game)}
    else
      {:error, error} -> {:error, error}
      {_, other} -> {:ok, other}
    end
  end

  def game_api(id) do
    post(
      "/multiquery",
      """
      query games "Game #{id}" {
        fields id,name,summary,cover.url,genres.name,multiplayer_modes.*,platforms.name,platforms.abbreviation,game_modes.name;
        where id = #{id};
        limit 1;
      };
      """
    )
  end

  def game_api_fun(id) do
    fn ->
      post(
        "/multiquery",
        """
        query games "Game #{id}" {
          fields id,name,summary,cover.url,genres.name,multiplayer_modes.*,platforms.name,platforms.abbreviation,game_modes.name;
          where id = #{id};
          limit 1;
        };
        """
      )
    end
  end

  def game_modes(:all) do
    # -- cache
    # Cachex.fetch(:igdb, "game_modes", fn ->
    #   %{body: resp} = post!("/game_modes", "f id,name,slug; limit 100;")
    #   {:commit, resp}
    # end)
    # -- /cache

    case post("/game_modes", "f id,name,slug; limit 100;") do
      {:ok, %{body: resp}} -> {:ok, resp}
      {:error, _} -> "idk"
    end
  end

  def game_modes(id) when is_integer(id) do
    game_modes([id])
  end

  def game_modes(ids) when is_list(ids) do
    game_modes(:all)
    |> case do
      {:error, msg} ->
        {:error, "Cache error: #{msg}"}

      {_, modes} ->
        modes
        |> Enum.filter(&(&1.id in ids))
        |> (&{:ok, &1}).()
    end
  end

  def platforms(:all) do
    Cachex.fetch(:igdb, "platforms", fn ->
      %{body: resp} =
        post!(
          "/platforms",
          "f abbreviation,name,platform_logo,slug; limit 500;"
        )

      {:commit, resp}
    end)
  end

  def platforms(ids) do
    ids = List.flatten([ids])

    platforms(:all)
    |> case do
      {:error, msg} ->
        {:error, "Cache error: #{msg}"}

      {_, platforms} ->
        platforms
        |> Enum.filter(&(&1.id in ids))
        |> (&{:ok, &1}).()
    end
  end

  def multiplayer_modes(:all) do
    # -- cache
    Cachex.fetch(:igdb, "multiplayer_modes", fn ->
      %{body: resp} = post!("/multiplayer_modes", "f *; limit 500;")

      {:commit, resp}
    end)

    # -- /cache

    case post("/mutiplayer_modes", "f *; limit 500;") do
      {:ok, %{body: resp}} -> {:ok, resp}
      {:error, _} -> {:error, "idk"}
    end
  end

  def multiplayer_modes(ids) do
    ids = List.flatten([ids]) |> Enum.join(",")

    # -- cache
    Cachex.fetch(:igdb, "multiplayer_modes/#{ids}", fn ->
      %{body: resp} = post!("/multiplayer_modes", "where id = (#{ids});" <> "f *;")

      {:commit, resp}
    end)

    # -- /cache

    case post("/multiplayer_modes", "where id = (#{ids});" <> "f *;") do
      {:ok, %{body: resp}} -> {:ok, resp}
      {:error, _} -> {:error, "idk"}
    end
  end

  def search_game_query(keyword, opts) do
    "search \"#{keyword}\";" <>
      "limit #{opts[:limit]};" <>
      "f #{game_fields()};"
  end

  def game_query(ids) do
    "where id = (#{Enum.join([ids], ",")});" <>
      "f #{game_fields()};"
  end

  def game_fields() do
    "name,follows,multiplayer_modes.onlinecoopmax,multiplayer_modes.onlinemax,release_dates.human,release_dates.region,release_dates.date"

    # "game_modes,multiplayer_modes.onlinecoopmax,multiplayer_,parent_game,age_ratings,alternative_names,category,cover,external_games,follows,genres,keywords,name,platforms,rating,release_dates,similar_games,slug,summary,tags,url"
  end

  def game_modes_query(ids) do
    "where id = (#{Enum.join(ids, ",")});" <>
      "f name,slug;"
  end

  def reset() do
    Cachex.reset(:igdb)
  end

  def categories() do
    %{
      0 => "main_game",
      1 => "dlc_addon",
      2 => "expansion",
      3 => "bundle",
      4 => "standalone_expansion",
      5 => "mod",
      6 => "episode",
      7 => "season",
      8 => "remake",
      9 => "remaster",
      10 => "expanded_game",
      11 => "port",
      12 => "fork"
    }
  end

  def categories(ids) when is_list(ids) do
    for id <- ids, reduce: [] do
      acc -> [categories()[id] | acc]
    end
  end

  def fetch_and_cache(key, val) when is_function(val) do
    case Cachex.fetch(:igdb, key, fn ->
           commit_or_ignore(val.())
         end) do
      {:error, error} ->
        {:error, error}

      {:ignore, error} ->
        {:error, error}

      {_, resp} ->
        {:ok, resp}
    end
  end

  def fetch_and_cache(key, val) do
    case Cachex.fetch(:igdb, key, fn ->
           commit_or_ignore(val)
         end) do
      {:error, error} ->
        {:error, error}

      {:ignore, error} ->
        {:error, error}

      {_, resp} ->
        {:ok, resp}
    end
  end

  def commit_or_ignore(val) do
    case val do
      {:ok, ret} ->
        {:commit, ret}

      {:error, err} ->
        {:ignore, err}
    end
  end
end
