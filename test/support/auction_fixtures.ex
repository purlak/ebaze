defmodule Ebaze.AuctionFixtures do
  use Phoenix.ConnTest

  def auction_fixture(:auction_invalid_attrs) do
    %{
      description: nil,
      end_time: nil,
      initial_price: nil,
      name: nil,
      photo_url: nil,
      sold: nil,
      start_time: nil
    }
  end

  def auction_fixture(:auction_update_attrs) do
    %{
      description: "some updated description",
      end_time: "2011-05-18T15:01:01Z",
      initial_price: "456.7",
      name: "some updated name",
      photo_url: "some updated photo_url",
      sold: false,
      start_time: "2011-05-18T15:01:01Z"
    }
  end

  def auction_fixture(:auction_create_attrs) do
    %{
      description: "some description",
      end_time: "2010-04-17T14:00:00Z",
      initial_price: "120.5",
      name: "some name",
      photo_url: "some photo_url",
      sold: true,
      start_time: "2010-04-17T14:00:00Z"
    }
  end

  def auction_fixture(:auction_create_attrs, user) do
    auction_fixture(:auction_create_attrs)
    |> Map.put(:created_by_id, user.id)
  end
end
