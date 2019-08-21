defmodule EbazeWeb.PageControllerTest do
  use EbazeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Ebaze!"
    assert html_response(conn, 200) =~ "New auction items listed everyday. Sell or Bid now!"
  end
end
