defmodule Howmanycanplay.Genres.GameGenre do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games_genres" do
    belongs_to(:game, Howmanycanplay.Games.Game)
    belongs_to(:genre, Howmanycanplay.Genres.Genre)

    timestamps()
  end

  @required ~w[game_id genre_id]a

  @doc false
  def changeset(game_genre, attrs) do
    game_genre
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> unique_constraint([:game_id, :genre_id], name: :games_genres_uniq_idx)
    |> foreign_key_constraint(:game_id)
    |> foreign_key_constraint(:genre_id)
  end
end
