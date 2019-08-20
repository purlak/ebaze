defmodule EbazeWeb.PageController do
  use EbazeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
