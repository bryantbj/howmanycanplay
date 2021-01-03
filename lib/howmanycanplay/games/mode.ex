defmodule Howmanycanplay.Games.Mode do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, except: [:__meta__, :game]}

  schema "modes" do
    field :name, :string
    field :description, :string
    field :player_min_num, :integer, default: 1
    field :player_max_num, :integer, null: false
    belongs_to :game, Howmanycanplay.Games.Game
    belongs_to :mode_type, Howmanycanplay.Games.ModeType

    timestamps()
  end

  @doc false
  def changeset(mode, attrs) do
    mode
    |> cast(attrs, [:name, :player_min_num, :player_max_num, :game_id, :mode_type_id])
    |> validate_required([:name, :player_max_num, :game_id, :mode_type_id])
    |> validate_length(:name, min: 1)
    |> validate_length(:description, max: 280)
    |> validate_number(:player_min_num, greater_than: 0)
    |> validate_number(:player_max_num, greater_than: 0)
  end
end
