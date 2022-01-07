defmodule Howmanycanplay.Repo.Migrations.CreateGamesGameModes do
  use Ecto.Migration

  def change do
    create table(:games_game_modes) do
      add :game_id, references(:games, on_delete: :nothing)
      add :game_mode_id, references(:game_modes, on_delete: :nothing)

      timestamps()
    end

    create index(:games_game_modes, [:game_id])
    create index(:games_game_modes, [:game_mode_id])
  end
end
