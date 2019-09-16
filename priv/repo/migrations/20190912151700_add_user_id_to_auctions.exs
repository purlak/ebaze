defmodule Ebaze.Repo.Migrations.AddUserIdToAuctions do
  use Ecto.Migration

  def change do
    alter table("auctions") do
      add :created_by_id, references("users"), null: false
    end
  end
end
