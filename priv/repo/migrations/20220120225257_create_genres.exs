defmodule Howmanycanplay.Repo.Migrations.CreateGenres do
  use Ecto.Migration

  def change do
    create table(:genres) do
      add :api_id, :integer
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:genres, [:api_id, :name], name: :genres_api_id_name_uniq_idx)
  end
end
