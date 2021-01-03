defmodule Howmanycanplay.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, except: [:__meta__]}

  schema "games" do
    field :name, :string
    has_many :modes, Howmanycanplay.Games.Mode

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
