defmodule WeNeedToWatch.Movies do
  @moduledoc """
  The Movies context.
  """

  import Ecto.Query, warn: false
  alias WeNeedToWatch.Repo

  alias WeNeedToWatch.Movies.Title

  @doc """
  Returns the list of titles.

  ## Examples

      iex> list_titles()
      [%Title{}, ...]

  """
  def list_titles do
    Repo.all(Title)
  end

  def list_titles(sorted: true) do
    query = from(t in Title, order_by: t.title)
    Repo.all(query)
  end
  def list_titles(:_sorted), do: list_titles()

  @doc """
  Gets a single title.

  Raises `Ecto.NoResultsError` if the Title does not exist.

  ## Examples

      iex> get_title!(123)
      %Title{}

      iex> get_title!(456)
      ** (Ecto.NoResultsError)

  """
  def get_title!(id), do: Repo.get!(Title, id)

  @doc """
  Creates a title.

  ## Examples

      iex> create_title(%{field: value})
      {:ok, %Title{}}

      iex> create_title(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_title(attrs \\ %{}) do
    %Title{}
    |> Title.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a title.

  ## Examples

      iex> update_title(title, %{field: new_value})
      {:ok, %Title{}}

      iex> update_title(title, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_title(%Title{} = title, attrs) do
    title
    |> Title.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Title.

  ## Examples

      iex> delete_title(title)
      {:ok, %Title{}}

      iex> delete_title(title)
      {:error, %Ecto.Changeset{}}

  """
  def delete_title(%Title{} = title) do
    Repo.delete(title)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking title changes.

  ## Examples

      iex> change_title(title)
      %Ecto.Changeset{source: %Title{}}

  """
  def change_title(%Title{} = title) do
    Title.changeset(title, %{})
  end
end
