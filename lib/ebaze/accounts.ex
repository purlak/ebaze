defmodule Ebaze.Accounts do
  import Ecto.Query, warn: false
  alias Ebaze.Repo

  alias Ebaze.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def authenticate_user(username, password) do
    case get_user(username) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, "User not found."}

      user ->
        if Bcrypt.verify_pass(password, user.password) do
          {:ok, user}
        else
          {:error, "Invalid Credentials"}
        end
    end
  end

  defp get_user(username) do
    Repo.one(from user in User, where: user.username == ^username)
  end
end
