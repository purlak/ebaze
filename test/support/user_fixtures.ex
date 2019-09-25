defmodule Ebaze.UserFixtures do
  use Phoenix.ConnTest

  alias Ebaze.Accounts

  @endpoint EbazeWeb.Endpoint

  def user_fixture(:user_attrs) do
    %{password: "some password", username: "some username"}
  end

  def user_fixture(:user_invalid_attrs) do
    %{password: nil, username: nil}
  end

  def user_fixture(:user_update_attrs) do
    %{password: "some updated password", username: "some updated username"}
  end

  def create_user() do
    {:ok, user} = Accounts.create_user(user_fixture(:user_attrs))
    user
  end

  def create_another_user() do
    {:ok, another_user} = Accounts.create_user(user_fixture(:user_update_attrs))

    another_user
  end

  def sign_in_user(_) do
    post(build_conn(), EbazeWeb.Router.Helpers.session_path(build_conn(), :create),
      user: %{password: "some password", username: "some username"}
    )
  end
end
