defmodule EbazeWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      alias EbazeWeb.Router.Helpers, as: Routes

      @endpoint EbazeWeb.Endpoint
      def session_conn() do
        opts =
          Plug.Session.init(
            store: :cookie,
            key: "foobar",
            encryption_salt: "encrypted cookie salt",
            signing_salt: "signing salt",
            log: false,
            encrypt: false
          )

        build_conn()
        |> Plug.Session.call(opts)
        |> fetch_session()
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ebaze.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Ebaze.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
