defmodule Howmanycanplay.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Howmanycanplay.Repo

  alias Howmanycanplay.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  def get_game_and_modes!(id) do
    Game
    |> Ecto.Query.preload(modes: :mode_type)
    |> Repo.get!(id)
  end

  @spec create_game(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def base_game_query, do: from(g in Game)

  def only_fields_query(fields) do
  end

  def search_games_query(query \\ Game, str) do
    str = "%#{str}%"

    query
    |> where([g], ilike(g.name, ^str))
    |> order_by([g], asc: g.name)
    |> preload(modes: :mode_type)
    |> limit(10)
  end

  def search_games(query \\ Game, str) do
    search_games_query(query, str) |> Repo.all()
  end

  def select_search_results_fields(query \\ Game) do
    query
    |> Ecto.Query.preload(modes: :mode_type)
  end

  def min_max_players(game) do
    game.modes
    |> Enum.reduce(%{min: nil, max: nil}, fn
      mode, %{min: nil, max: nil} ->
        %{min: mode.player_min_num, max: mode.player_max_num}

      %{player_min_num: mode_min, player_max_num: mode_max}, %{min: min, max: max} ->
        %{min: (mode_min < min && mode_min) || min, max: (mode_max > max && mode_max) || max}

      _mode, map ->
        map
    end)
  end

  alias Howmanycanplay.Games.Mode

  @doc """
  Returns the list of modes.

  ## Examples

      iex> list_modes()
      [%Mode{}, ...]

  """
  def list_modes do
    Repo.all(Mode)
  end

  @doc """
  Gets a single mode.

  Raises `Ecto.NoResultsError` if the Game mode does not exist.

  ## Examples

      iex> get_mode!(123)
      %Mode{}

      iex> get_mode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mode!(id), do: Repo.get!(Mode, id)

  @doc """
  Creates a mode.

  ## Examples

      iex> create_mode(%{field: value})
      {:ok, %Mode{}}

      iex> create_mode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mode(attrs \\ %{}) do
    %Mode{}
    |> Mode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mode.

  ## Examples

      iex> update_mode(mode, %{field: new_value})
      {:ok, %Mode{}}

      iex> update_mode(mode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mode(%Mode{} = mode, attrs) do
    mode
    |> Mode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mode.

  ## Examples

      iex> delete_mode(mode)
      {:ok, %Mode{}}

      iex> delete_mode(mode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mode(%Mode{} = mode) do
    Repo.delete(mode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mode changes.

  ## Examples

      iex> change_mode(mode)
      %Ecto.Changeset{data: %Mode{}}

  """
  def change_mode(%Mode{} = mode, attrs \\ %{}) do
    Mode.changeset(mode, attrs)
  end
end
