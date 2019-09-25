defmodule Ebaze.Auctions do
  import Ecto.Query, warn: false
  alias Ebaze.Repo

  alias Ebaze.Auctions.Auction

  def list_auctions do
    Repo.all(Auction)
  end

  def list_my_auctions(user) do
    query()
    |> where(created_by_id: ^user.id)
    |> Repo.all()
  end

  def list_open_auctions() do
    now = DateTime.utc_now()
    not_specified = nil

    query()
    |> where([auction], auction.end_time > ^now or auction.end_time == ^not_specified)
    |> Repo.all()
  end

  def get_auction!(id), do: Repo.get!(Auction, id)

  def create_auction(attrs \\ %{}) do
    %Auction{}
    |> Auction.changeset(attrs)
    |> Repo.insert()
  end

  def update_auction(%Auction{} = auction, attrs) do
    auction
    |> Auction.changeset(attrs)
    |> Repo.update()
  end

  def delete_auction(%Auction{} = auction) do
    Repo.delete(auction)
  end

  def change_auction(%Auction{} = auction) do
    Auction.changeset(auction, %{})
  end

  defp query do
    from(auction in Auction)
  end
end
