defmodule Howmanycanplay.GenresTest do
  use Howmanycanplay.DataCase

  alias Howmanycanplay.Genres
  import Howmanycanplay.Factory

  describe "genres" do
    alias Howmanycanplay.Genres.Genre

    import Howmanycanplay.GenresFixtures

    @invalid_attrs %{api_id: nil, name: nil}

    test "list_genres/0 returns all genres" do
      genre = genre_fixture()
      assert Genres.list_genres() == [genre]
    end

    test "get_genre!/1 returns the genre with given id" do
      genre = genre_fixture()
      assert Genres.get_genre!(genre.id) == genre
    end

    test "create_genre/1 with valid data creates a genre" do
      valid_attrs = %{api_id: 42, name: "some name"}

      assert {:ok, %Genre{} = genre} = Genres.create_genre(valid_attrs)
      assert genre.api_id == 42
      assert genre.name == "some name"
    end

    test "create_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Genres.create_genre(@invalid_attrs)
    end

    test "update_genre/2 with valid data updates the genre" do
      genre = genre_fixture()
      update_attrs = %{api_id: 43, name: "some updated name"}

      assert {:ok, %Genre{} = genre} = Genres.update_genre(genre, update_attrs)
      assert genre.api_id == 43
      assert genre.name == "some updated name"
    end

    test "update_genre/2 with invalid data returns error changeset" do
      genre = genre_fixture()
      assert {:error, %Ecto.Changeset{}} = Genres.update_genre(genre, @invalid_attrs)
      assert genre == Genres.get_genre!(genre.id)
    end

    test "delete_genre/1 deletes the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{}} = Genres.delete_genre(genre)
      assert_raise Ecto.NoResultsError, fn -> Genres.get_genre!(genre.id) end
    end

    test "change_genre/1 returns a genre changeset" do
      genre = genre_fixture()
      assert %Ecto.Changeset{} = Genres.change_genre(genre)
    end

    test "api_id and name are unique" do
      valid_attrs = %{api_id: 44, name: "some name"}

      assert {:ok, %Genre{}} = Genres.create_genre(valid_attrs)
      assert {:error, %{errors: [{:api_id, _}]}} = Genres.create_genre(valid_attrs)
    end
  end

  describe "games_genres" do
    alias Howmanycanplay.Genres.GameGenre

    import Howmanycanplay.GenresFixtures

    @invalid_attrs %{}

    test "list_games_genres/0 returns all games_genres" do
      game_genre = insert(:game_genre)
      assert Genres.list_games_genres() |> Enum.map(& &1.id) == [game_genre.id]
    end

    test "get_game_genre!/1 returns the game_genre with given id" do
      game_genre = insert(:game_genre)
      assert Genres.get_game_genre!(game_genre.id).id == game_genre.id
    end

    test "create_game_genre/1 with valid data creates a game_genre" do
      # valid_attrs = build(:game_genre)
      valid_attrs = %{
        game_id: insert(:game).id,
        genre_id: insert(:genre).id
      }

      assert {:ok, %GameGenre{}} = Genres.create_game_genre(valid_attrs)
    end

    test "create_game_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Genres.create_game_genre(@invalid_attrs)
    end

    test "update_game_genre/2 with valid data updates the game_genre" do
      game_genre =
        insert(:game_genre)
        |> then(&Genres.get_game_genre!(&1.id))

      another_genre = insert(:genre)
      update_attrs = %{genre_id: another_genre.id}

      assert {:ok, %GameGenre{}} = Genres.update_game_genre(game_genre, update_attrs)
    end

    test "update_game_genre/2 with invalid data returns error changeset" do
      game_genre =
        insert(:game_genre)
        |> then(&Genres.get_game_genre!(&1.id))

      assert {:error, %Ecto.Changeset{}} =
               Genres.update_game_genre(game_genre, %{game_id: nil, genre_id: nil})

      assert {:error, %Ecto.Changeset{}} = Genres.update_game_genre(game_genre, %{game_id: nil})
      assert {:error, %Ecto.Changeset{}} = Genres.update_game_genre(game_genre, %{genre_id: nil})

      assert game_genre == Genres.get_game_genre!(game_genre.id)
    end

    test "delete_game_genre/1 deletes the game_genre" do
      game_genre = insert(:game_genre)
      assert {:ok, %GameGenre{}} = Genres.delete_game_genre(game_genre)
      assert_raise Ecto.NoResultsError, fn -> Genres.get_game_genre!(game_genre.id) end
    end

    test "change_game_genre/1 returns a game_genre changeset" do
      game_genre = insert(:game_genre)
      assert %Ecto.Changeset{} = Genres.change_game_genre(game_genre)
    end
  end
end
