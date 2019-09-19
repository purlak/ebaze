defmodule EbazeWeb.SessionControllerTest do
  use EbazeWeb.ConnCase

  import Ebaze.UserFixtures

  describe "new session" do
    test "GET /sign-in renders sign-in form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign in"
    end

    test "POST /sign-in renders index when credentials are valid", %{conn: conn} do
      create_user()
      conn = post(conn, Routes.session_path(conn, :create), user: user_fixture(:user_attrs))
      assert get_flash(conn, :info) =~ "welcome back!"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "POST /sign-in index page displays option to add 'new listing'", %{conn: conn} do
      create_user()
      user_conn = post(conn, Routes.session_path(conn, :create), user: user_fixture(:user_attrs))
      assert redirected_to(user_conn) == Routes.page_path(user_conn, :index)
      conn = get(user_conn, Routes.page_path(user_conn, :index))
      assert html_response(conn, 200) =~ "New Listing"
    end
  end
end
