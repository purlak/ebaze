defmodule Ebaze.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Ebaze.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Ebaze.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ebaze.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Ebaze.Repo, {:shared, self()})
    end

    :ok
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
