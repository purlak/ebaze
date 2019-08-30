defmodule Ebaze.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :ebaze,
    error_handler: Ebaze.Accounts.ErrorHandler,
    module: Ebaze.Accounts.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
