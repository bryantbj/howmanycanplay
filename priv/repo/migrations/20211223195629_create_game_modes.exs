defmodule Howmanycanplay.Repo.Migrations.CreateGameModes do
  use Ecto.Migration

  def change do
    create table(:game_modes) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:game_modes, [:name], name: :game_mode_name_uniq_indx)
  end
end
