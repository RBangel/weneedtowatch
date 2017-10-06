defmodule WeNeedToWatchWeb.KatyAndRaelyn do
  use WeNeedToWatchWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
