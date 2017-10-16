defmodule WeNeedToWatchWeb.PageController do
  use WeNeedToWatchWeb, :controller

  alias WeNeedToWatch.Movies
  alias WeNeedToWatch.Movies.Movie

  def index(conn, _params) do
    movies = Movies.list_movies(sorted: true)
    render(conn, "index.html", movies: movies)
  end

  def show(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def new(conn, _params) do
    changeset = Movies.change_movie(%Movie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movie" => movie_params}) do
    case Movies.create_movie(movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    {:ok, _movie} = Movies.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
