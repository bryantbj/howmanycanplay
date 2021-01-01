defmodule Howmanycanplay.Repo.Migrations.CreateModes do
  use Ecto.Migration

  def change do
    create table(:modes) do
      add :name, :string, null: false
      add :description, :string, size: 280
      add :game_id, references(:games)
      add :mode_type_id, references(:mode_types)
      add :player_min_num, :integer, default: 1
      add :player_max_num, :integer, null: false

      timestamps()
    end

    create unique_index(:modes, [:name, :game_id])
  end
end
