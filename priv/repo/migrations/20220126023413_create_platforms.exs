defmodule Howmanycanplay.Repo.Migrations.CreatePlatforms do
  use Ecto.Migration

  def change do
    create table(:platforms) do
      add :api_id, :integer
      add :name, :string, null: false
      add :alternative_name, :string
      add :abbreviation, :string
      add :slug, :string

      timestamps()
    end

    create unique_index(:platforms, [:api_id, :name], name: :platforms_api_id_name_uniq_idx)
  end
end
