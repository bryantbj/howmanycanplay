defmodule Howmanycanplay.Games.GameMultiplayerMode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games_multiplayer_modes" do
    field :max_coop_count, :integer
    field :max_mode_count, :integer
    field :game_id, :id
    field :multiplayer_mode_id, :id

    timestamps()
  end

  @doc false
  def changeset(game_multiplayer_mode, attrs) do
    game_multiplayer_mode
    |> cast(attrs, [:max_coop_count, :max_mode_count])
    |> validate_required([:max_coop_count, :max_mode_count])
  end
end
