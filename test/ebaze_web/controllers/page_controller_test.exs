defmodule EbazeWeb.PageControllerTest do
  use EbazeWeb.ConnCase

  describe "get landing page " do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Welcome to Ebaze!"
      assert html_response(conn, 200) =~ "New auction items listed everyday. Sell or Bid now!"
    end

    test "GET / displays auction listings", %{conn: conn} do
      conn = get(conn, "/")

      assert conn.assigns[:auctions]
    end
  end
end
