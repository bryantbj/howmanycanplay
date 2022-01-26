defmodule Howmanycanplay.Repo.Migrations.CreateGamesGenres do
  use Ecto.Migration

  def change do
    create table(:games_genres) do
      add :game_id, references(:games, on_delete: :nothing), null: false
      add :genre_id, references(:genres, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:games_genres, [:game_id, :genre_id], name: :games_genres_uniq_idx)
  end
end
