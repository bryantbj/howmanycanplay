defmodule Howmanycanplay.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:games, [:name])
  end
end
