defmodule Howmanycanplay.GamesTest do
  use Howmanycanplay.DataCase

  alias Howmanycanplay.Games

  describe "games" do
    alias Howmanycanplay.Games.Game

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "game_modes" do
    alias Howmanycanplay.Games.GameMode

    @valid_attrs %{name: "some name", player_max_num: 42, player_min_num: 42}
    @update_attrs %{name: "some updated name", player_max_num: 43, player_min_num: 43}
    @invalid_attrs %{name: nil, player_max_num: nil, player_min_num: nil}

    def game_mode_fixture(attrs \\ %{}) do
      {:ok, game_mode} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game_mode()

      game_mode
    end

    test "list_game_modes/0 returns all game_modes" do
      game_mode = game_mode_fixture()
      assert Games.list_game_modes() == [game_mode]
    end

    test "get_game_mode!/1 returns the game_mode with given id" do
      game_mode = game_mode_fixture()
      assert Games.get_game_mode!(game_mode.id) == game_mode
    end

    test "create_game_mode/1 with valid data creates a game_mode" do
      assert {:ok, %GameMode{} = game_mode} = Games.create_game_mode(@valid_attrs)
      assert game_mode.name == "some name"
      assert game_mode.player_max_num == 42
      assert game_mode.player_min_num == 42
    end

    test "create_game_mode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game_mode(@invalid_attrs)
    end

    test "update_game_mode/2 with valid data updates the game_mode" do
      game_mode = game_mode_fixture()
      assert {:ok, %GameMode{} = game_mode} = Games.update_game_mode(game_mode, @update_attrs)
      assert game_mode.name == "some updated name"
      assert game_mode.player_max_num == 43
      assert game_mode.player_min_num == 43
    end

    test "update_game_mode/2 with invalid data returns error changeset" do
      game_mode = game_mode_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game_mode(game_mode, @invalid_attrs)
      assert game_mode == Games.get_game_mode!(game_mode.id)
    end

    test "delete_game_mode/1 deletes the game_mode" do
      game_mode = game_mode_fixture()
      assert {:ok, %GameMode{}} = Games.delete_game_mode(game_mode)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game_mode!(game_mode.id) end
    end

    test "change_game_mode/1 returns a game_mode changeset" do
      game_mode = game_mode_fixture()
      assert %Ecto.Changeset{} = Games.change_game_mode(game_mode)
    end
  end
end
