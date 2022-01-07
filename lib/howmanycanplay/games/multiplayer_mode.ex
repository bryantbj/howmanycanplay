defmodule Howmanycanplay.Games.MultiplayerMode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "multiplayer_modes" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(multiplayer_mode, attrs) do
    multiplayer_mode
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
