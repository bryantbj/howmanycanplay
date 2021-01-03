defmodule Howmanycanplay.Games.ModeType do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, except: [:__meta__]}

  schema "mode_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(mode_type, attrs) do
    mode_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
