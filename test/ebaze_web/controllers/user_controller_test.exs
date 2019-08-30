defmodule EbazeWeb.UserControllerTest do
  use EbazeWeb.ConnCase

  alias Ebaze.Accounts

  @create_attrs %{password: "some password", username: "some username"}
  @update_attrs %{password: "some updated password", username: "some updated username"}
  @invalid_attrs %{password: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    setup [:create_user]

    test "redirects to index when data is valid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @create_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)

      assert html_response(conn, 302)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)

      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = post(conn, Routes.session_path(conn, :create), user: @create_attrs)
      conn = get(conn, Routes.user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = post(conn, Routes.session_path(conn, :create), user: @create_attrs)
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :show, user)

      conn = get(conn, Routes.user_path(conn, :show, user))

      assert html_response(conn, 200) =~ "User updated successfully"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = post(conn, Routes.session_path(conn, :create), user: @create_attrs)
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = post(conn, Routes.session_path(conn, :create), user: @create_attrs)
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert redirected_to(conn) == Routes.user_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
