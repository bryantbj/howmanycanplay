defmodule Howmanycanplay.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm"

    create table(:games) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:games, [:name])
    execute "CREATE INDEX trgm_idx_games_name ON games USING gin (name gin_trgm_ops)"
  end
end
