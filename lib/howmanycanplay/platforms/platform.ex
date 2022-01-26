defmodule Howmanycanplay.Platforms.Platform do
  use Ecto.Schema
  import Ecto.Changeset

  schema "platforms" do
    field :abbreviation, :string
    field :alternative_name, :string
    field :api_id, :integer
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(platform, attrs) do
    platform
    |> cast(attrs, [:api_id, :name, :alternative_name, :abbreviation, :slug])
    |> validate_required([:api_id, :name, :alternative_name, :abbreviation, :slug])
  end
end
