defmodule Ebaze.Auctions.Auction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ebaze.{Accounts.User}

  schema "auctions" do
    field :description, :string
    field :end_time, :utc_datetime
    field :initial_price, :decimal
    field :name, :string
    field :photo_url, :string
    field :sold, :boolean, default: false
    field :start_time, :utc_datetime
    belongs_to :created_by, User
    timestamps()
  end

  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [
      :name,
      :description,
      :sold,
      :initial_price,
      :start_time,
      :end_time,
      :photo_url,
      :created_by_id
    ])
    |> validate_required([
      :name,
      :description,
      :sold,
      :initial_price,
      :photo_url,
      :created_by_id
    ])
    |> foreign_key_constraint(:users, name: :auctions_created_by_id_fkey)
  end
end
