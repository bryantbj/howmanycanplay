defmodule Howmanycanplay.Repo.Migrations.CreateGameModes do
  use Ecto.Migration

  def change do
    create table(:game_modes) do
      add :name, :string

      timestamps()
    end
  end
end
