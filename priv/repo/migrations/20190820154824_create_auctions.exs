defmodule Ebaze.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :name, :string
      add :description, :string
      add :sold_status, :boolean, default: false, null: false
      add :initial_price, :decimal
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :photo_url, :string

      timestamps()
    end
  end
end
