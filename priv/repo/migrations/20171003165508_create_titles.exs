defmodule WeNeedToWatch.Repo.Migrations.CreateTitles do
  use Ecto.Migration

  def change do
    create table(:titles) do
      add :title, :string

      timestamps()
    end

    create unique_index(:titles, [:title])
  end
end
