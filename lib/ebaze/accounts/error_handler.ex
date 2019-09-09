defmodule Ebaze.Accounts.ErrorHandler do
  import Plug.Conn
  use EbazeWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    if body == "unauthenticated" do
      conn
      |> put_flash(:error, "Sign-in to continue")
      |> redirect(to: Routes.session_path(conn, :new))
    end
  end
end
