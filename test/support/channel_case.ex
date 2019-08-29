defmodule EbazeWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ChannelTest

      @endpoint EbazeWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ebaze.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Ebaze.Repo, {:shared, self()})
    end

    :ok
  end
end
