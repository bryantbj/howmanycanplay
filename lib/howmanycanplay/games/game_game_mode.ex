defmodule Howmanycanplay.Games.GameGameMode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games_game_modes" do
    field :game_id, :id
    field :game_mode_id, :id

    timestamps()
  end

  @doc false
  def changeset(game_game_mode, attrs) do
    game_game_mode
    |> cast(attrs, [])
    |> validate_required([])
  end
end
