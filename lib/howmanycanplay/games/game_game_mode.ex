defmodule Howmanycanplay.Games.GameGameMode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games_game_modes" do
    belongs_to(:game, Howmanycanplay.Games.Game)
    belongs_to(:game_mode, Howmanycanplay.Games.GameMode)

    timestamps()
  end

  @required ~w[game_id game_mode_id]a

  @doc false
  def changeset(game_game_mode, attrs) do
    game_game_mode
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
