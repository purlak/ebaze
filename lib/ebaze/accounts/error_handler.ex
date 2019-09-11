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
    else
      conn
      |> put_resp_content_type("text/plain")
      |> send_resp(401, body)
    end
  end
end
