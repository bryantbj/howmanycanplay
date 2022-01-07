defmodule Howmanycanplay.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :summary, :text

      timestamps()
    end
  end
end
