defmodule Beautify.Router do
  use Beautify.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "ic.html"]
    #plug Intercooler.Plug.Format
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :ic_layout do
    plug :put_layout, {Beautify.LayoutView, "app.ic.html"}
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

    #get "/clients/:client_id/edit/adresses/new", AdressController, :new
    #get "/clients/:client_id/new/adresses/new", AdressController, :new

    #get "clients/:client_id/edit/adresses/edit"
    #get "clients/:client_id/new/adresses/edit"

    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/clients", ClientController
    resources "/adresses", AdressController
    resources "/blind_prices", BlindPriceController
    resources "/blind_price_sheets", BlindPriceSheetController
    resources "/suppliers", SupplierController

  end

  scope "/", Beautify do
    pipe_through [:browser, :with_session, :ic_layout]

    get "/clients/:client_id/edit/adresses/new", AdressController, :new
    get "/clients/:client_id/new/adresses/new", AdressController, :new

  end

  # Other scopes may use custom stacks.
  # scope "/api", Beautify do
  #   pipe_through :api
  # end
end
