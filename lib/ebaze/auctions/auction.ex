defmodule Ebaze.Auctions.Auction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auctions" do
    field :description, :string
    field :end_time, :utc_datetime
    field :initial_price, :decimal
    field :name, :string
    field :photo_url, :string
    field :sold_status, :boolean, default: false
    field :start_time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [:name, :description, :sold_status, :initial_price, :start_time, :end_time, :photo_url])
    |> validate_required([:name, :description, :sold_status, :initial_price, :start_time, :end_time, :photo_url])
  end
end
