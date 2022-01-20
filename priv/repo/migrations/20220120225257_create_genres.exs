defmodule Howmanycanplay.Repo.Migrations.CreateGenres do
  use Ecto.Migration

  def change do
    create table(:genres) do
      add :api_id, :integer
      add :name, :string

      timestamps()
    end
  end
end
