defmodule Howmanycanplay.Repo.Migrations.CreateModeTypes do
  use Ecto.Migration

  def change do
    create table(:mode_types) do
      add :name, :string

      timestamps()
    end

    create unique_index(:mode_types, [:name])

  end
end
