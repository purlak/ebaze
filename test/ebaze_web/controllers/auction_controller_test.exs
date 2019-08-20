defmodule EbazeWeb.AuctionControllerTest do
  use EbazeWeb.ConnCase

  alias Ebaze.Auctions

  @create_attrs %{description: "some description", end_time: "2010-04-17T14:00:00Z", initial_price: "120.5", name: "some name", photo_url: "some photo_url", sold: true, start_time: "2010-04-17T14:00:00Z"}
  @update_attrs %{description: "some updated description", end_time: "2011-05-18T15:01:01Z", initial_price: "456.7", name: "some updated name", photo_url: "some updated photo_url", sold: false, start_time: "2011-05-18T15:01:01Z"}
  @invalid_attrs %{description: nil, end_time: nil, initial_price: nil, name: nil, photo_url: nil, sold: nil, start_time: nil}

  def fixture(:auction) do
    {:ok, auction} = Auctions.create_auction(@create_attrs)
    auction
  end

  describe "index" do
    test "lists all auctions", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Auctions"
    end
  end

  describe "new auction" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :new))
      assert html_response(conn, 200) =~ "New Auction"
    end
  end

  describe "create auction" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.auction_path(conn, :create), auction: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.auction_path(conn, :show, id)

      conn = get(conn, Routes.auction_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Auction"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.auction_path(conn, :create), auction: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Auction"
    end
  end

  describe "edit auction" do
    setup [:create_auction]

    test "renders form for editing chosen auction", %{conn: conn, auction: auction} do
      conn = get(conn, Routes.auction_path(conn, :edit, auction))
      assert html_response(conn, 200) =~ "Edit Auction"
    end
  end

  describe "update auction" do
    setup [:create_auction]

    test "redirects when data is valid", %{conn: conn, auction: auction} do
      conn = put(conn, Routes.auction_path(conn, :update, auction), auction: @update_attrs)
      assert redirected_to(conn) == Routes.auction_path(conn, :show, auction)

      conn = get(conn, Routes.auction_path(conn, :show, auction))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, auction: auction} do
      conn = put(conn, Routes.auction_path(conn, :update, auction), auction: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Auction"
    end
  end

  describe "delete auction" do
    setup [:create_auction]

    test "deletes chosen auction", %{conn: conn, auction: auction} do
      conn = delete(conn, Routes.auction_path(conn, :delete, auction))
      assert redirected_to(conn) == Routes.auction_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.auction_path(conn, :show, auction))
      end
    end
  end

  defp create_auction(_) do
    auction = fixture(:auction)
    {:ok, auction: auction}
  end
end
