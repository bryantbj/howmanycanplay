defmodule Howmanycanplay.Repo.Migrations.CreateGamesMultiplayerModes do
  use Ecto.Migration

  def change do
    create table(:games_multiplayer_modes) do
      add :max_coop_count, :integer
      add :max_mode_count, :integer
      add :game_id, references(:games, on_delete: :nothing), null: false
      add :multiplayer_mode_id, references(:multiplayer_modes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:games_multiplayer_modes, [:game_id])
    create index(:games_multiplayer_modes, [:multiplayer_mode_id])
  end
end
