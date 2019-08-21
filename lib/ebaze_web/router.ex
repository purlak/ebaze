defmodule EbazeWeb.Router do
  use EbazeWeb, :router

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
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController

    resources "/auctions", AuctionController

    resources "/sign-in", SessionController, only: [:new, :create]
  end
end
