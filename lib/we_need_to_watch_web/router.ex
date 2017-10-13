defmodule WeNeedToWatchWeb.Router do
  use WeNeedToWatchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth,
      username: Application.get_env(:we_need_to_watch, :basic_auth)[:username],
      password: Application.get_env(:we_need_to_watch, :basic_auth)[:password]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeNeedToWatchWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/:id", PageController, :show
    post "/", PageController, :create
    delete "/:id", PageController, :delete

    get "/katyandraelyn", KatyAndRaelyn, :index
    resources "/titles", TitleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", WeNeedToWatchWeb do
  #   pipe_through :api
  # end
end
