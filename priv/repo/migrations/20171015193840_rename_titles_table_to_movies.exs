defmodule WeNeedToWatch.Repo.Migrations.RenameTitlesTableToMovies do
  use Ecto.Migration

  def change do
    rename table(:titles), to: table(:movies)
  end
end
