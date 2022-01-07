defmodule Howmanycanplay.Repo.Migrations.CreateMultiplayerModes do
  use Ecto.Migration

  def change do
    create table(:multiplayer_modes) do
      add :name, :string

      timestamps()
    end
  end
end
