defmodule Howmanycanplay.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Howmanycanplay.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        name: "some name",
        summary: "some summary"
      })
      |> Howmanycanplay.Games.create_game()

    game
  end

  @doc """
  Generate a game_mode.
  """
  def game_mode_fixture(attrs \\ %{}) do
    {:ok, game_mode} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Howmanycanplay.Games.create_game_mode()

    game_mode
  end

  @doc """
  Generate a multiplayer_mode.
  """
  def multiplayer_mode_fixture(attrs \\ %{}) do
    {:ok, multiplayer_mode} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Howmanycanplay.Games.create_multiplayer_mode()

    multiplayer_mode
  end

  @doc """
  Generate a game_game_mode.
  """
  def game_game_mode_fixture(attrs \\ %{}) do
    {:ok, game_game_mode} =
      attrs
      |> Enum.into(%{

      })
      |> Howmanycanplay.Games.create_game_game_mode()

    game_game_mode
  end

  @doc """
  Generate a game_multiplayer_mode.
  """
  def game_multiplayer_mode_fixture(attrs \\ %{}) do
    {:ok, game_multiplayer_mode} =
      attrs
      |> Enum.into(%{
        max_coop_count: 42,
        max_mode_count: 42
      })
      |> Howmanycanplay.Games.create_game_multiplayer_mode()

    game_multiplayer_mode
  end
end
