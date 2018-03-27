defmodule Beautify.Router do
  use Beautify.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Beautify.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Beautify do
    pipe_through [:browser, :with_session]

    get "/", PageController, :index

    resources "/users", UserController, only: [:show, :new, :create]

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Beautify do
  #   pipe_through :api
  # end
end
