defmodule Ebaze.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username, message: "username is not unique. try again")
    |> validate_length(:password, min: 6, message: "password should be 6 or more characters")
  end
end
