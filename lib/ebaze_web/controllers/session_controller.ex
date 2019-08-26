defmodule EbazeWeb.SessionController do
  use EbazeWeb, :controller

  alias Ebaze.{Accounts, Accounts.User, Accounts.Guardian}

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/")
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :create))
    end
  end

  def create(conn, %{
        "user" => %{"username" => username, "password" => password}
      }) do
    Accounts.authenticate_user(username, password)
    |> sign_in_reply(conn)
  end

  defp sign_in_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Hello #{user.username}, welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp sign_in_reply({:error, _}, conn) do
    conn
    |> put_flash(:error, "Invalid credentials")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  def signout(conn, _) do
    conn
    |> Guardian.Plug.sign_out(_opts = [])
    |> put_flash(:info, "Thanks for visiting! Goodbye!")
    |> redirect(to: "/sign-in/new")
  end
end
