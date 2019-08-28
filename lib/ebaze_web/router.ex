defmodule EbazeWeb.Router do
  use EbazeWeb, :router

  pipeline :auth do
    plug Ebaze.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EbazeWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    resources "/users", UserController

    resources "/auctions", AuctionController

    resources "/sign-in", SessionController, only: [:new, :create]

    post "/signout", SessionController, :signout
  end

  scope "/", EbazeWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/users", UserController

    resources "/auctions", AuctionController

    get "/protected", PageController, :protected
  end
end
