defmodule Ebaze.AuctionsTest do
  use Ebaze.DataCase

  alias Ebaze.{Auctions, Auctions.Auction}

  import Ebaze.UserFixtures
  import Ebaze.AuctionFixtures

  describe "get auctions" do
    test "list_auctions/0 returns all auctions" do
      user = create_user()
      {:ok, auction} = Auctions.create_auction(auction_fixture(:auction_create_attrs, user))
      assert Auctions.list_auctions() == [auction]
    end

    test "list_open_auctions/0 returns open auctions and not closed auctions" do
      user = create_user()
      {:ok, open_auction} = Auctions.create_auction(auction_fixture(:auction_open_attrs, user))

      {:ok, closed_auction} =
        Auctions.create_auction(auction_fixture(:auction_closed_attrs, user))

      assert Auctions.list_open_auctions() == [open_auction]
      assert Auctions.list_open_auctions() != [closed_auction]
    end

    test "list_my_auctions/1 returns user's own auctions" do
      user = create_user()
      another_user = create_another_user()

      {:ok, user_auction} = Auctions.create_auction(auction_fixture(:auction_open_attrs, user))

      {:ok, another_user_auction} =
        Auctions.create_auction(auction_fixture(:auction_closed_attrs, another_user))

      assert Auctions.list_my_auctions(user) == [user_auction]
      assert Auctions.list_my_auctions(user) != [another_user_auction]
    end

    test "get_auction!/1 returns the auction with given id" do
      user = create_user()
      {:ok, auction} = Auctions.create_auction(auction_fixture(:auction_create_attrs, user))
      assert Auctions.get_auction!(auction.id) == auction
    end
  end

  describe "create auction" do
    test "create_auction/1 with valid data creates a auction" do
      user = create_user()

      assert {:ok, %Auction{} = auction} =
               Auctions.create_auction(auction_fixture(:auction_create_attrs, user))

      assert auction.description == "some description"
      assert auction.end_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert auction.initial_price == Decimal.new("120.5")
      assert auction.name == "some name"
      assert auction.photo_url == "some photo_url"
      assert auction.sold == true
      assert auction.start_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_auction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Auctions.create_auction(auction_fixture(:auction_invalid_attrs))
    end
  end

  describe "modify auctions" do
    test "update_auction/2 with valid data updates the auction" do
      user = create_user()
      {:ok, auction} = Auctions.create_auction(auction_fixture(:auction_create_attrs, user))

      assert {:ok, %Auction{} = auction} =
               Auctions.update_auction(auction, auction_fixture(:auction_update_attrs))

      assert auction.description == "some updated description"
      assert auction.end_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert auction.initial_price == Decimal.new("456.7")
      assert auction.name == "some updated name"
      assert auction.photo_url == "some updated photo_url"
      assert auction.sold == false
      assert auction.start_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_auction/2 with invalid data returns error changeset" do
      user = create_user()
      {:ok, auction} = Auctions.create_auction(auction_fixture(:auction_create_attrs, user))

      assert {:error, %Ecto.Changeset{}} =
               Auctions.update_auction(auction, auction_fixture(:auction_invalid_attrs))

      assert auction == Auctions.get_auction!(auction.id)
    end

    test "delete_auction/1 deletes the auction" do
      user = create_user()
      {:ok, auction} = Auctions.create_auction(auction_fixture(:auction_create_attrs, user))
      assert {:ok, %Auction{}} = Auctions.delete_auction(auction)
      assert_raise Ecto.NoResultsError, fn -> Auctions.get_auction!(auction.id) end
    end
  end

  describe "return auction struct" do
    test "change_auction/1 returns a auction changeset" do
      user = create_user()
      {:ok, auction} = Auctions.create_auction(auction_fixture(:auction_create_attrs, user))
      assert %Ecto.Changeset{} = Auctions.change_auction(auction)
    end
  end
end
