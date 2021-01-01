defmodule Howmanycanplay.Repo.Migrations.CreatePlatforms do
  use Ecto.Migration

  def change do
    create table(:platforms) do
      add :name, :string

      timestamps()
    end

    create unique_index(:platforms, [:name])

  end
end
