defmodule Howmanycanplay.GamesTest do
  use Howmanycanplay.DataCase
  alias Howmanycanplay.Games
  import Howmanycanplay.Factory
  import Mock

  describe "games" do
    alias Howmanycanplay.Games.Game

    import Howmanycanplay.GamesFixtures

    @invalid_attrs %{name: nil, summary: nil}

    test "list_games/0 returns all games" do
      game = insert(:game)
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = insert(:game)
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{name: "some name", summary: "some summary"}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.name == "some name"
      assert game.summary == "some summary"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = insert(:game)
      update_attrs = %{name: "some updated name", summary: "some updated summary"}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.name == "some updated name"
      assert game.summary == "some updated summary"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = insert(:game) |> then(&Games.get_game!(&1.id))
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = insert(:game)
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = build(:game)
      assert %Ecto.Changeset{} = Games.change_game(game)
    end

    test "get_or_fetch_and_create_game!/1 returns a local game" do
      game = insert(:game)

      assert {:ok, %Game{} = found_game} = Games.get_or_fetch_and_create_game!(game.api_id)
      assert game.id == found_game.id
    end

    test "get_game_by_api_id!/1 returns a local game" do
      game = insert(:game)

      assert %Game{} = Games.get_game_by_api_id!(game.api_id)
    end

    test "get_or_fetch_and_create_game!/1 returns an external game" do
      with_mock Igdb, game_api: fn id -> params_for(:api_game_http, %{id: id}) end do
        id = 1_000

        assert nil == Games.get_game_by_api_id!(id)

        Games.get_or_fetch_and_create_game!(id)

        assert %Game{api_id: ^id} = Games.get_game_by_api_id!(id)
      end
    end
  end

  describe "games creation from api games" do
    alias Howmanycanplay.{Games.Game, Repo}
    import Howmanycanplay.Factory

    test "can create a game from ApiGame" do
      %{api_id: id} = api_game = build(:api_game)
      assert {:ok, %Game{api_id: ^id}} = Games.create_game_from_api_game(api_game)

      given =
        from(
          g in Game,
          where: g.api_id == ^id,
          preload: [:genres]
        )
        |> Repo.one()
        |> Map.take([:genres])
        |> Enum.map(& &1.name)

      assert api_game.genres == given
    end
  end

  describe "game_modes" do
    alias Howmanycanplay.Games.GameMode

    import Howmanycanplay.GamesFixtures

    @invalid_attrs %{name: nil}

    test "list_game_modes/0 returns all game_modes" do
      game_mode = game_mode_fixture()
      assert Games.list_game_modes() == [game_mode]
    end

    test "get_game_mode!/1 returns the game_mode with given id" do
      game_mode = game_mode_fixture()
      assert Games.get_game_mode!(game_mode.id) == game_mode
    end

    test "create_game_mode/1 with valid data creates a game_mode" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %GameMode{} = game_mode} = Games.create_game_mode(valid_attrs)
      assert game_mode.name == "some name"
    end

    test "create_game_mode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game_mode(@invalid_attrs)
    end

    test "update_game_mode/2 with valid data updates the game_mode" do
      game_mode = game_mode_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %GameMode{} = game_mode} = Games.update_game_mode(game_mode, update_attrs)
      assert game_mode.name == "some updated name"
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

  describe "multiplayer_modes" do
    alias Howmanycanplay.Games.MultiplayerMode

    import Howmanycanplay.GamesFixtures

    @invalid_attrs %{name: nil}

    test "list_multiplayer_modes/0 returns all multiplayer_modes" do
      multiplayer_mode = multiplayer_mode_fixture()
      assert Games.list_multiplayer_modes() == [multiplayer_mode]
    end

    test "get_multiplayer_mode!/1 returns the multiplayer_mode with given id" do
      multiplayer_mode = multiplayer_mode_fixture()
      assert Games.get_multiplayer_mode!(multiplayer_mode.id) == multiplayer_mode
    end

    test "create_multiplayer_mode/1 with valid data creates a multiplayer_mode" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %MultiplayerMode{} = multiplayer_mode} =
               Games.create_multiplayer_mode(valid_attrs)

      assert multiplayer_mode.name == "some name"
    end

    test "create_multiplayer_mode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_multiplayer_mode(@invalid_attrs)
    end

    test "update_multiplayer_mode/2 with valid data updates the multiplayer_mode" do
      multiplayer_mode = multiplayer_mode_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %MultiplayerMode{} = multiplayer_mode} =
               Games.update_multiplayer_mode(multiplayer_mode, update_attrs)

      assert multiplayer_mode.name == "some updated name"
    end

    test "update_multiplayer_mode/2 with invalid data returns error changeset" do
      multiplayer_mode = multiplayer_mode_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Games.update_multiplayer_mode(multiplayer_mode, @invalid_attrs)

      assert multiplayer_mode == Games.get_multiplayer_mode!(multiplayer_mode.id)
    end

    test "delete_multiplayer_mode/1 deletes the multiplayer_mode" do
      multiplayer_mode = multiplayer_mode_fixture()
      assert {:ok, %MultiplayerMode{}} = Games.delete_multiplayer_mode(multiplayer_mode)
      assert_raise Ecto.NoResultsError, fn -> Games.get_multiplayer_mode!(multiplayer_mode.id) end
    end

    test "change_multiplayer_mode/1 returns a multiplayer_mode changeset" do
      multiplayer_mode = multiplayer_mode_fixture()
      assert %Ecto.Changeset{} = Games.change_multiplayer_mode(multiplayer_mode)
    end
  end

  describe "games_game_modes" do
    alias Howmanycanplay.Games.GameGameMode

    import Howmanycanplay.GamesFixtures

    @invalid_attrs %{game_id: nil, game_mode_id: nil}

    test "list_games_game_modes/0 returns all games_game_modes" do
      game_game_mode = insert(:game_game_mode) |> then(&Games.get_game_game_mode!(&1.id))
      assert Games.list_games_game_modes() == [game_game_mode]
    end

    test "get_game_game_mode!/1 returns the game_game_mode with given id" do
      game_game_mode = insert(:game_game_mode) |> then(&Games.get_game_game_mode!(&1.id))
      assert Games.get_game_game_mode!(game_game_mode.id) == game_game_mode
    end

    test "create_game_game_mode/1 with valid data creates a game_game_mode" do
      valid_attrs = params_with_assocs(:game_game_mode)

      assert {:ok, %GameGameMode{} = _game_game_mode} = Games.create_game_game_mode(valid_attrs)
    end

    test "create_game_game_mode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game_game_mode(@invalid_attrs)
    end

    test "update_game_game_mode/2 with valid data updates the game_game_mode" do
      game_game_mode = insert(:game_game_mode)
      another_game = insert(:game)
      update_attrs = %{game_id: another_game.id}

      assert {:ok, %GameGameMode{} = _game_game_mode} =
               Games.update_game_game_mode(game_game_mode, update_attrs)
    end

    test "update_game_game_mode/2 with invalid data returns error changeset" do
      game_game_mode = insert(:game_game_mode) |> then(&Games.get_game_game_mode!(&1.id))

      assert {:error, %Ecto.Changeset{}} =
               Games.update_game_game_mode(game_game_mode, @invalid_attrs)

      assert game_game_mode == Games.get_game_game_mode!(game_game_mode.id)
    end

    test "delete_game_game_mode/1 deletes the game_game_mode" do
      game_game_mode = insert(:game_game_mode)
      assert {:ok, %GameGameMode{}} = Games.delete_game_game_mode(game_game_mode)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game_game_mode!(game_game_mode.id) end
    end

    test "change_game_game_mode/1 returns a game_game_mode changeset" do
      game_game_mode = build(:game_game_mode)
      assert %Ecto.Changeset{} = Games.change_game_game_mode(game_game_mode)
    end
  end

  describe "games_multiplayer_modes" do
    alias Howmanycanplay.Games.GameMultiplayerMode

    import Howmanycanplay.GamesFixtures

    @invalid_attrs %{max_coop_count: nil, max_mode_count: nil}

    test "list_games_multiplayer_modes/0 returns all games_multiplayer_modes" do
      game_multiplayer_mode = game_multiplayer_mode_fixture()
      assert Games.list_games_multiplayer_modes() == [game_multiplayer_mode]
    end

    test "get_game_multiplayer_mode!/1 returns the game_multiplayer_mode with given id" do
      game_multiplayer_mode = game_multiplayer_mode_fixture()
      assert Games.get_game_multiplayer_mode!(game_multiplayer_mode.id) == game_multiplayer_mode
    end

    test "create_game_multiplayer_mode/1 with valid data creates a game_multiplayer_mode" do
      valid_attrs = %{max_coop_count: 42, max_mode_count: 42}

      assert {:ok, %GameMultiplayerMode{} = game_multiplayer_mode} =
               Games.create_game_multiplayer_mode(valid_attrs)

      assert game_multiplayer_mode.max_coop_count == 42
      assert game_multiplayer_mode.max_mode_count == 42
    end

    test "create_game_multiplayer_mode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game_multiplayer_mode(@invalid_attrs)
    end

    test "update_game_multiplayer_mode/2 with valid data updates the game_multiplayer_mode" do
      game_multiplayer_mode = game_multiplayer_mode_fixture()
      update_attrs = %{max_coop_count: 43, max_mode_count: 43}

      assert {:ok, %GameMultiplayerMode{} = game_multiplayer_mode} =
               Games.update_game_multiplayer_mode(game_multiplayer_mode, update_attrs)

      assert game_multiplayer_mode.max_coop_count == 43
      assert game_multiplayer_mode.max_mode_count == 43
    end

    test "update_game_multiplayer_mode/2 with invalid data returns error changeset" do
      game_multiplayer_mode = game_multiplayer_mode_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Games.update_game_multiplayer_mode(game_multiplayer_mode, @invalid_attrs)

      assert game_multiplayer_mode == Games.get_game_multiplayer_mode!(game_multiplayer_mode.id)
    end

    test "delete_game_multiplayer_mode/1 deletes the game_multiplayer_mode" do
      game_multiplayer_mode = game_multiplayer_mode_fixture()

      assert {:ok, %GameMultiplayerMode{}} =
               Games.delete_game_multiplayer_mode(game_multiplayer_mode)

      assert_raise Ecto.NoResultsError, fn ->
        Games.get_game_multiplayer_mode!(game_multiplayer_mode.id)
      end
    end

    test "change_game_multiplayer_mode/1 returns a game_multiplayer_mode changeset" do
      game_multiplayer_mode = game_multiplayer_mode_fixture()
      assert %Ecto.Changeset{} = Games.change_game_multiplayer_mode(game_multiplayer_mode)
    end
  end
end
