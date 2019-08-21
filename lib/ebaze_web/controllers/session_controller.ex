defmodule EbazeWeb.SessionController do
  use EbazeWeb, :controller

  alias Ebaze.Repo
  alias Ebaze.{Accounts, Accounts.User}

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})

    render(conn, "new.html",
      changeset: Accounts.change_user(%User{}),
      action: Routes.session_path(conn, :create)
    )
  end

  def create(conn, %{
        "user" => %{"username" => username, "password" => password}
      }) do
    conn
    |> put_flash(:info, "Hello #{username}, Welcome back")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
