defmodule WeNeedToWatchWeb.PageController do
  use WeNeedToWatchWeb, :controller

  alias WeNeedToWatch.Movies
  alias WeNeedToWatch.Movies.Title

  def index(conn, _params) do
    titles = Movies.list_titles(sorted: true)
    render(conn, "index.html", titles: titles)
  end

  def show(conn, %{"id" => id}) do
    title = Movies.get_title!(id)
    render(conn, "show.html", title: title)
  end

  def new(conn, _params) do
    changeset = Movies.change_title(%Title{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"title" => title_params}) do
    case Movies.create_title(title_params) do
      {:ok, title} ->
        conn
        |> put_flash(:info, "Title created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    title = Movies.get_title!(id)
    {:ok, _title} = Movies.delete_title(title)

    conn
    |> put_flash(:info, "Title deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
