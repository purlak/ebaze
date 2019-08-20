defmodule Ebaze.AuctionsTest do
  use Ebaze.DataCase

  alias Ebaze.Auctions

  describe "auctions" do
    alias Ebaze.Auctions.Auction

    @valid_attrs %{description: "some description", end_time: "2010-04-17T14:00:00Z", initial_price: "120.5", name: "some name", photo_url: "some photo_url", sold: true, start_time: "2010-04-17T14:00:00Z"}
    @update_attrs %{description: "some updated description", end_time: "2011-05-18T15:01:01Z", initial_price: "456.7", name: "some updated name", photo_url: "some updated photo_url", sold: false, start_time: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{description: nil, end_time: nil, initial_price: nil, name: nil, photo_url: nil, sold: nil, start_time: nil}

    def auction_fixture(attrs \\ %{}) do
      {:ok, auction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auctions.create_auction()

      auction
    end

    test "list_auctions/0 returns all auctions" do
      auction = auction_fixture()
      assert Auctions.list_auctions() == [auction]
    end

    test "get_auction!/1 returns the auction with given id" do
      auction = auction_fixture()
      assert Auctions.get_auction!(auction.id) == auction
    end

    test "create_auction/1 with valid data creates a auction" do
      assert {:ok, %Auction{} = auction} = Auctions.create_auction(@valid_attrs)
      assert auction.description == "some description"
      assert auction.end_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert auction.initial_price == Decimal.new("120.5")
      assert auction.name == "some name"
      assert auction.photo_url == "some photo_url"
      assert auction.sold == true
      assert auction.start_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_auction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auctions.create_auction(@invalid_attrs)
    end

    test "update_auction/2 with valid data updates the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{} = auction} = Auctions.update_auction(auction, @update_attrs)
      assert auction.description == "some updated description"
      assert auction.end_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert auction.initial_price == Decimal.new("456.7")
      assert auction.name == "some updated name"
      assert auction.photo_url == "some updated photo_url"
      assert auction.sold == false
      assert auction.start_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_auction/2 with invalid data returns error changeset" do
      auction = auction_fixture()
      assert {:error, %Ecto.Changeset{}} = Auctions.update_auction(auction, @invalid_attrs)
      assert auction == Auctions.get_auction!(auction.id)
    end

    test "delete_auction/1 deletes the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{}} = Auctions.delete_auction(auction)
      assert_raise Ecto.NoResultsError, fn -> Auctions.get_auction!(auction.id) end
    end

    test "change_auction/1 returns a auction changeset" do
      auction = auction_fixture()
      assert %Ecto.Changeset{} = Auctions.change_auction(auction)
    end
  end
end
