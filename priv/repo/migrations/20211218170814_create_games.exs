defmodule Howmanycanplay.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :summary, :text
      add :api_id, :integer

      timestamps()
    end

    create unique_index(:games, [:api_id], name: :games_api_id_uniq_idx)
  end
end
