defmodule Ebaze.Repo.Migrations.UpdateAuctionsTableChangeSoldStatusColumnName do
  use Ecto.Migration

  def change do
    rename table(:auctions), :sold_status, to: :sold
  end
end
