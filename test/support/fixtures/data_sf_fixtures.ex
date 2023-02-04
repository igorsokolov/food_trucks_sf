defmodule FoodTrucksMap.DataSFFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTrucksMap.DataSF` context.
  """

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    {:ok, food_truck} =
      attrs
      |> Enum.into(%{
        address: "some address",
        company: "some company",
        food_items: "some food_items",
        location_id: 42,
        type: "some type",
        geo_location: %Geo.Point{
          coordinates: { -1.0, -1.0 }
        }
      })
      |> FoodTrucksMap.DataSF.create_food_truck()

    food_truck
  end
end
