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

  @doc """
  Returns list of games which match the leading search `term`.

    ## Examples
    iex>search_games("rocket leag")
    [%Game{}, ...]
  """
  def search_games(term) do
    from g in Game,
      where: ilike(g.name, ^"#{term}%")
  end

  alias Howmanycanplay.Games.GameMode

  @doc """
  Returns the list of game_modes.

  ## Examples

      iex> list_game_modes()
      [%GameMode{}, ...]

  """
  def list_game_modes do
    Repo.all(GameMode)
  end

  @doc """
  Gets a single game_mode.

  Raises `Ecto.NoResultsError` if the Game mode does not exist.

  ## Examples

      iex> get_game_mode!(123)
      %GameMode{}

      iex> get_game_mode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_mode!(id), do: Repo.get!(GameMode, id)

  @doc """
  Creates a game_mode.

  ## Examples

      iex> create_game_mode(%{field: value})
      {:ok, %GameMode{}}

      iex> create_game_mode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_mode(attrs \\ %{}) do
    %GameMode{}
    |> GameMode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_mode.

  ## Examples

      iex> update_game_mode(game_mode, %{field: new_value})
      {:ok, %GameMode{}}

      iex> update_game_mode(game_mode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_mode(%GameMode{} = game_mode, attrs) do
    game_mode
    |> GameMode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_mode.

  ## Examples

      iex> delete_game_mode(game_mode)
      {:ok, %GameMode{}}

      iex> delete_game_mode(game_mode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_mode(%GameMode{} = game_mode) do
    Repo.delete(game_mode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_mode changes.

  ## Examples

      iex> change_game_mode(game_mode)
      %Ecto.Changeset{data: %GameMode{}}

  """
  def change_game_mode(%GameMode{} = game_mode, attrs \\ %{}) do
    GameMode.changeset(game_mode, attrs)
  end

  alias Howmanycanplay.Games.MultiplayerMode

  @doc """
  Returns the list of multiplayer_modes.

  ## Examples

      iex> list_multiplayer_modes()
      [%MultiplayerMode{}, ...]

  """
  def list_multiplayer_modes do
    Repo.all(MultiplayerMode)
  end

  @doc """
  Gets a single multiplayer_mode.

  Raises `Ecto.NoResultsError` if the Multiplayer mode does not exist.

  ## Examples

      iex> get_multiplayer_mode!(123)
      %MultiplayerMode{}

      iex> get_multiplayer_mode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_multiplayer_mode!(id), do: Repo.get!(MultiplayerMode, id)

  @doc """
  Creates a multiplayer_mode.

  ## Examples

      iex> create_multiplayer_mode(%{field: value})
      {:ok, %MultiplayerMode{}}

      iex> create_multiplayer_mode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_multiplayer_mode(attrs \\ %{}) do
    %MultiplayerMode{}
    |> MultiplayerMode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a multiplayer_mode.

  ## Examples

      iex> update_multiplayer_mode(multiplayer_mode, %{field: new_value})
      {:ok, %MultiplayerMode{}}

      iex> update_multiplayer_mode(multiplayer_mode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_multiplayer_mode(%MultiplayerMode{} = multiplayer_mode, attrs) do
    multiplayer_mode
    |> MultiplayerMode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a multiplayer_mode.

  ## Examples

      iex> delete_multiplayer_mode(multiplayer_mode)
      {:ok, %MultiplayerMode{}}

      iex> delete_multiplayer_mode(multiplayer_mode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_multiplayer_mode(%MultiplayerMode{} = multiplayer_mode) do
    Repo.delete(multiplayer_mode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking multiplayer_mode changes.

  ## Examples

      iex> change_multiplayer_mode(multiplayer_mode)
      %Ecto.Changeset{data: %MultiplayerMode{}}

  """
  def change_multiplayer_mode(%MultiplayerMode{} = multiplayer_mode, attrs \\ %{}) do
    MultiplayerMode.changeset(multiplayer_mode, attrs)
  end

  alias Howmanycanplay.Games.GameGameMode

  @doc """
  Returns the list of games_game_modes.

  ## Examples

      iex> list_games_game_modes()
      [%GameGameMode{}, ...]

  """
  def list_games_game_modes do
    Repo.all(GameGameMode)
  end

  @doc """
  Gets a single game_game_mode.

  Raises `Ecto.NoResultsError` if the Game game mode does not exist.

  ## Examples

      iex> get_game_game_mode!(123)
      %GameGameMode{}

      iex> get_game_game_mode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_game_mode!(id), do: Repo.get!(GameGameMode, id)

  @doc """
  Creates a game_game_mode.

  ## Examples

      iex> create_game_game_mode(%{field: value})
      {:ok, %GameGameMode{}}

      iex> create_game_game_mode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_game_mode(attrs \\ %{}) do
    %GameGameMode{}
    |> GameGameMode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_game_mode.

  ## Examples

      iex> update_game_game_mode(game_game_mode, %{field: new_value})
      {:ok, %GameGameMode{}}

      iex> update_game_game_mode(game_game_mode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_game_mode(%GameGameMode{} = game_game_mode, attrs) do
    game_game_mode
    |> GameGameMode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_game_mode.

  ## Examples

      iex> delete_game_game_mode(game_game_mode)
      {:ok, %GameGameMode{}}

      iex> delete_game_game_mode(game_game_mode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_game_mode(%GameGameMode{} = game_game_mode) do
    Repo.delete(game_game_mode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_game_mode changes.

  ## Examples

      iex> change_game_game_mode(game_game_mode)
      %Ecto.Changeset{data: %GameGameMode{}}

  """
  def change_game_game_mode(%GameGameMode{} = game_game_mode, attrs \\ %{}) do
    GameGameMode.changeset(game_game_mode, attrs)
  end

  alias Howmanycanplay.Games.GameMultiplayerMode

  @doc """
  Returns the list of games_multiplayer_modes.

  ## Examples

      iex> list_games_multiplayer_modes()
      [%GameMultiplayerMode{}, ...]

  """
  def list_games_multiplayer_modes do
    Repo.all(GameMultiplayerMode)
  end

  @doc """
  Gets a single game_multiplayer_mode.

  Raises `Ecto.NoResultsError` if the Game multiplayer mode does not exist.

  ## Examples

      iex> get_game_multiplayer_mode!(123)
      %GameMultiplayerMode{}

      iex> get_game_multiplayer_mode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_multiplayer_mode!(id), do: Repo.get!(GameMultiplayerMode, id)

  @doc """
  Creates a game_multiplayer_mode.

  ## Examples

      iex> create_game_multiplayer_mode(%{field: value})
      {:ok, %GameMultiplayerMode{}}

      iex> create_game_multiplayer_mode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_multiplayer_mode(attrs \\ %{}) do
    %GameMultiplayerMode{}
    |> GameMultiplayerMode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_multiplayer_mode.

  ## Examples

      iex> update_game_multiplayer_mode(game_multiplayer_mode, %{field: new_value})
      {:ok, %GameMultiplayerMode{}}

      iex> update_game_multiplayer_mode(game_multiplayer_mode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_multiplayer_mode(%GameMultiplayerMode{} = game_multiplayer_mode, attrs) do
    game_multiplayer_mode
    |> GameMultiplayerMode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_multiplayer_mode.

  ## Examples

      iex> delete_game_multiplayer_mode(game_multiplayer_mode)
      {:ok, %GameMultiplayerMode{}}

      iex> delete_game_multiplayer_mode(game_multiplayer_mode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_multiplayer_mode(%GameMultiplayerMode{} = game_multiplayer_mode) do
    Repo.delete(game_multiplayer_mode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_multiplayer_mode changes.

  ## Examples

      iex> change_game_multiplayer_mode(game_multiplayer_mode)
      %Ecto.Changeset{data: %GameMultiplayerMode{}}

  """
  def change_game_multiplayer_mode(%GameMultiplayerMode{} = game_multiplayer_mode, attrs \\ %{}) do
    GameMultiplayerMode.changeset(game_multiplayer_mode, attrs)
  end
end
