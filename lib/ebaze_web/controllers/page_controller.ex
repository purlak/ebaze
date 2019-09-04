defmodule EbazeWeb.PageController do
  use EbazeWeb, :controller

  alias Ebaze.Auctions

  def index(conn, _params) do
    auctions = Auctions.list_auctions()
    render(conn, "index.html", auctions: auctions)
  end

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_user: user)
  end
end
