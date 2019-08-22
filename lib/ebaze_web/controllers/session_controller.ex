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
    Accounts.authenticate_user(username, password)
    |> sign_in(conn)
  end

  defp sign_in({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Hello #{user.username}, welcome back!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp sign_in({:error, _}, conn) do
    conn
    |> put_flash(:error, "Invalid credentials")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
