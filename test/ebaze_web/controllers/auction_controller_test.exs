defmodule EbazeWeb.AuctionControllerTest do
  use EbazeWeb.ConnCase

  alias Ebaze.Accounts
  alias Ebaze.Auctions

  @create_attrs %{
    description: "some description",
    end_time: "2010-04-17T14:00:00Z",
    initial_price: "120.5",
    name: "some name",
    photo_url: "some photo_url",
    sold: true,
    start_time: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    description: "some updated description",
    end_time: "2011-05-18T15:01:01Z",
    initial_price: "456.7",
    name: "some updated name",
    photo_url: "some updated photo_url",
    sold: false,
    start_time: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{
    description: nil,
    end_time: nil,
    initial_price: nil,
    name: nil,
    photo_url: nil,
    sold: nil,
    start_time: nil
  }

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
      user_conn = create_and_sign_in_user(conn)
      post_signin_conn = get(user_conn, Routes.auction_path(user_conn, :new))
      assert html_response(post_signin_conn, 200) =~ "New Auction"
    end

    test "redirects to GET /sign-in/new when user is not signed in", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :new))
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end

  describe "create auction" do
    test "redirects to show when data is valid", %{conn: conn} do
      user_conn = create_and_sign_in_user(conn)

      post_signin_conn =
        post(user_conn, Routes.auction_path(user_conn, :create), auction: @create_attrs)

      assert %{id: id} = redirected_params(post_signin_conn)
      assert redirected_to(post_signin_conn) == Routes.auction_path(post_signin_conn, :show, id)

      conn = get(post_signin_conn, Routes.auction_path(post_signin_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Auction"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user_conn = create_and_sign_in_user(conn)

      post_signin_conn =
        post(user_conn, Routes.auction_path(user_conn, :create), auction: @invalid_attrs)

      assert html_response(post_signin_conn, 200)
    end
  end

  describe "edit auction" do
    test "renders form for editing chosen auction", %{conn: conn} do
      user_conn = create_and_sign_in_user(conn)
      {:ok, auction} = Auctions.create_auction(@create_attrs)
      post_signin_conn = get(user_conn, Routes.auction_path(user_conn, :edit, auction))
      assert html_response(post_signin_conn, 200) =~ "Edit Auction"
    end
  end

  describe "update auction" do
    test "redirects when data is valid", %{conn: conn} do
      user_conn = create_and_sign_in_user(conn)
      {:ok, auction} = Auctions.create_auction(@create_attrs)

      post_signin_conn =
        put(user_conn, Routes.auction_path(user_conn, :update, auction), auction: @update_attrs)

      assert redirected_to(post_signin_conn) ==
               Routes.auction_path(post_signin_conn, :show, auction)

      conn = get(post_signin_conn, Routes.auction_path(post_signin_conn, :show, auction))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user_conn = create_and_sign_in_user(conn)
      {:ok, auction} = Auctions.create_auction(@create_attrs)

      post_signin_conn =
        put(user_conn, Routes.auction_path(user_conn, :update, auction), auction: @invalid_attrs)

      assert html_response(post_signin_conn, 200) =~ "Edit Auction"
    end
  end

  describe "delete auction" do
    test "deletes chosen auction", %{conn: conn} do
      user_conn = create_and_sign_in_user(conn)
      {:ok, auction} = Auctions.create_auction(@create_attrs)

      post_signin_conn = delete(user_conn, Routes.auction_path(user_conn, :delete, auction))
      assert redirected_to(post_signin_conn) == Routes.auction_path(post_signin_conn, :index)

      assert_error_sent 404, fn ->
        get(post_signin_conn, Routes.auction_path(post_signin_conn, :show, auction))
      end
    end
  end

  defp create_and_sign_in_user(_) do
    {:ok, _user} = Accounts.create_user(%{password: "some password", username: "some username"})

    post(build_conn(), Routes.session_path(build_conn(), :create),
      user: %{password: "some password", username: "some username"}
    )
  end
end
