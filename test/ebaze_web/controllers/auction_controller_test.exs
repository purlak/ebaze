defmodule EbazeWeb.AuctionControllerTest do
  use EbazeWeb.ConnCase

  alias Ebaze.Auctions

  import Ebaze.AuctionFixtures
  import Ebaze.UserFixtures

  describe "index" do
    test "lists all auctions", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Auctions"
    end
  end

  describe "new auction" do
    test "renders form", %{conn: conn} do
      create_user()
      user_conn = sign_in_user(conn)
      post_signin_conn = get(user_conn, Routes.auction_path(user_conn, :new))
      assert html_response(post_signin_conn, 200) =~ "New Auction"
    end

    test "redirects to GET signin/new when user is not signed in", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :new))
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end

  describe "create auction" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = create_user()
      user_conn = sign_in_user(conn)

      post_signin_conn =
        post(user_conn, Routes.auction_path(user_conn, :create), auction: auction_attrs(user))

      assert %{id: id} = redirected_params(post_signin_conn)
      assert redirected_to(post_signin_conn) == Routes.auction_path(post_signin_conn, :show, id)

      conn = get(post_signin_conn, Routes.auction_path(post_signin_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Auction"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      create_user()
      user_conn = sign_in_user(conn)

      post_signin_conn =
        post(user_conn, Routes.auction_path(user_conn, :create),
          auction: auction_fixture(:auction_invalid_attrs)
        )

      assert html_response(post_signin_conn, 200)
    end
  end

  describe "edit auction" do
    test "renders form for editing chosen auction", %{conn: conn} do
      user = create_user()
      user_conn = sign_in_user(conn)
      {:ok, auction} = Auctions.create_auction(auction_attrs(user))
      post_signin_conn = get(user_conn, Routes.auction_path(user_conn, :edit, auction))
      assert html_response(post_signin_conn, 200) =~ "Edit Auction"
    end
  end

  describe "update auction" do
    test "redirects when data is valid", %{conn: conn} do
      user = create_user()
      user_conn = sign_in_user(conn)

      {:ok, auction} = Auctions.create_auction(auction_attrs(user))

      post_signin_conn =
        put(user_conn, Routes.auction_path(user_conn, :update, auction),
          auction: auction_fixture(:auction_update_attrs)
        )

      assert redirected_to(post_signin_conn) ==
               Routes.auction_path(post_signin_conn, :show, auction)

      conn = get(post_signin_conn, Routes.auction_path(post_signin_conn, :show, auction))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = create_user()
      user_conn = sign_in_user(conn)

      {:ok, auction} = Auctions.create_auction(auction_attrs(user))

      post_signin_conn =
        put(user_conn, Routes.auction_path(user_conn, :update, auction),
          auction: auction_fixture(:auction_invalid_attrs)
        )

      assert html_response(post_signin_conn, 200) =~ "Edit Auction"
    end
  end

  describe "delete auction" do
    test "deletes chosen auction", %{conn: conn} do
      user = create_user()
      user_conn = sign_in_user(conn)

      {:ok, auction} = Auctions.create_auction(auction_attrs(user))

      post_signin_conn = delete(user_conn, Routes.auction_path(user_conn, :delete, auction))
      assert redirected_to(post_signin_conn) == Routes.auction_path(post_signin_conn, :index)

      assert_error_sent 404, fn ->
        get(post_signin_conn, Routes.auction_path(post_signin_conn, :show, auction))
      end
    end
  end
end
