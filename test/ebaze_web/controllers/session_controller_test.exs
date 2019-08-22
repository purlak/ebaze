defmodule EbazeWeb.SessionControllerTest do
  use EbazeWeb.ConnCase
  alias Ebaze.Accounts

  @user_attrs %{
    "username" => "username",
    "password" => "password"
  }

  describe "new session" do
    test "renders sign-in form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign in"
    end

    test "renders index when credentials are valid", %{conn: conn} do
      Accounts.create_user(@user_attrs)
      conn = post(conn, Routes.session_path(conn, :create), user: @user_attrs)
      assert get_flash(conn, :info) =~ "welcome back!"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end
