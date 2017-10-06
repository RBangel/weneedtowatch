defmodule WeNeedToWatch.Movies.Title do
  use Ecto.Schema
  import Ecto.Changeset
  alias WeNeedToWatch.Movies.Title


  schema "titles" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Title{} = title, attrs) do
    title
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
