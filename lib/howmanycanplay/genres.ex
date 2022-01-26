defmodule Howmanycanplay.Genres do
  @moduledoc """
  The Genres context.
  """

  import Ecto.Query, warn: false
  alias Howmanycanplay.Repo

  alias Howmanycanplay.Genres.Genre

  @doc """
  Returns the list of genres.

  ## Examples

      iex> list_genres()
      [%Genre{}, ...]

  """
  def list_genres do
    Repo.all(Genre)
  end

  @doc """
  Gets a single genre.

  Raises `Ecto.NoResultsError` if the Genre does not exist.

  ## Examples

      iex> get_genre!(123)
      %Genre{}

      iex> get_genre!(456)
      ** (Ecto.NoResultsError)

  """
  def get_genre!(id), do: Repo.get!(Genre, id)

  @doc """
  Creates a genre.

  ## Examples

      iex> create_genre(%{field: value})
      {:ok, %Genre{}}

      iex> create_genre(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a genre.

  ## Examples

      iex> update_genre(genre, %{field: new_value})
      {:ok, %Genre{}}

      iex> update_genre(genre, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a genre.

  ## Examples

      iex> delete_genre(genre)
      {:ok, %Genre{}}

      iex> delete_genre(genre)
      {:error, %Ecto.Changeset{}}

  """
  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking genre changes.

  ## Examples

      iex> change_genre(genre)
      %Ecto.Changeset{data: %Genre{}}

  """
  def change_genre(%Genre{} = genre, attrs \\ %{}) do
    Genre.changeset(genre, attrs)
  end

  alias Howmanycanplay.Genres.GameGenre

  @doc """
  Returns the list of games_genres.

  ## Examples

      iex> list_games_genres()
      [%GameGenre{}, ...]

  """
  def list_games_genres do
    Repo.all(GameGenre)
  end

  @doc """
  Gets a single game_genre.

  Raises `Ecto.NoResultsError` if the Game genre does not exist.

  ## Examples

      iex> get_game_genre!(123)
      %GameGenre{}

      iex> get_game_genre!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_genre!(id), do: Repo.get!(GameGenre, id)

  @doc """
  Creates a game_genre.

  ## Examples

      iex> create_game_genre(%{field: value})
      {:ok, %GameGenre{}}

      iex> create_game_genre(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_genre(attrs \\ %{}) do
    %GameGenre{}
    |> GameGenre.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_genre.

  ## Examples

      iex> update_game_genre(game_genre, %{field: new_value})
      {:ok, %GameGenre{}}

      iex> update_game_genre(game_genre, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_genre(%GameGenre{} = game_genre, attrs) do
    game_genre
    |> GameGenre.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_genre.

  ## Examples

      iex> delete_game_genre(game_genre)
      {:ok, %GameGenre{}}

      iex> delete_game_genre(game_genre)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_genre(%GameGenre{} = game_genre) do
    Repo.delete(game_genre)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_genre changes.

  ## Examples

      iex> change_game_genre(game_genre)
      %Ecto.Changeset{data: %GameGenre{}}

  """
  def change_game_genre(%GameGenre{} = game_genre, attrs \\ %{}) do
    GameGenre.changeset(game_genre, attrs)
  end
end
