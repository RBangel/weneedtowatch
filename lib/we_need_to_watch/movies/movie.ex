defmodule WeNeedToWatch.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  alias WeNeedToWatch.Movies.Movie


  schema "movies" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Movie{} = movie, attrs) do
    movie
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
