defmodule Ebaze.Repo do
  use Ecto.Repo,
    otp_app: :ebaze,
    adapter: Ecto.Adapters.Postgres
end
