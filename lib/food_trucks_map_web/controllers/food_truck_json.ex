defmodule FoodTrucksMapWeb.FoodTruckJSON do
  alias FoodTrucksMap.DataSF.FoodTruck

  @doc """
  Renders a list of food_trucks.
  """
  def index(%{food_trucks: food_trucks}) do
    %{data: for(food_truck <- food_trucks, do: data(food_truck))}
  end

  @doc """
  Renders a single food_truck.
  """
  def show(%{food_truck: food_truck}) do
    %{data: data(food_truck)}
  end

  defp data(%FoodTruck{} = food_truck) do
    %{
      id: food_truck.id,
      company_name: food_truck.company,
      type: food_truck.type,
      address: food_truck.address,
      food: food_truck.food_items,
      geo_location: food_truck.geo_location
    }
  end
end
