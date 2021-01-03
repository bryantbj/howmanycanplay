defmodule Howmanycanplay.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :name_tsv, :tsvector

      timestamps()
    end

    create unique_index(:games, [:name])
    create index(:games, [:name_tsv], using: :gin)

    execute """
    CREATE TRIGGER games_name_tsv_trigger BEFORE INSERT OR UPDATE
    ON games FOR EACH ROW EXECUTE PROCEDURE
    tsvector_update_trigger(name_tsv, 'pg_catalog.english', name)
    """
  end
end
