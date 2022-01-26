defmodule Howmanycanplay.Games.GameMode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_modes" do
    field :name, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(game_mode, attrs) do
    game_mode
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint([:name], name: :game_mode_name_uniq_indx)
  end
end
