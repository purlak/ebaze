defmodule EbazeWeb.PageControllerTest do
  use EbazeWeb.ConnCase

  import Ebaze.UserFixtures
  import Ebaze.AuctionFixtures
  alias Ebaze.Auctions

  describe "get landing page " do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Welcome to Ebaze!"
      assert html_response(conn, 200) =~ "New auction items listed everyday. Sell or Bid now!"
    end

    test "GET / displays only open auction listings", %{conn: conn} do
      user = create_user()
      {:ok, open_auction} = Auctions.create_auction(auction_fixture(:auction_open_attrs, user))

      {:ok, closed_auction} =
        Auctions.create_auction(auction_fixture(:auction_closed_attrs, user))

      conn = get(conn, "/")

      assert html_response(conn, 200) =~ "#{open_auction.name}"
      assert html_response(conn, 200) != ~s("#{closed_auction.name}")
    end
  end
end
