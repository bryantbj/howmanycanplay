defmodule Howmanycanplay.Genres.Genre do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genres" do
    field :api_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:api_id, :name])
    |> validate_required([:api_id, :name])
    |> unique_constraint([:api_id, :name], name: :genres_api_id_name_uniq_idx)
  end
end
