defmodule FoodTrucksMapWeb.FoodTruckController do
  use FoodTrucksMapWeb, :controller

  alias FoodTrucksMap.DataSF
  alias FoodTrucksMap.DataSF.FoodTruck

  action_fallback FoodTrucksMapWeb.FallbackController

  def index(conn, _params) do
    food_trucks = DataSF.list_food_trucks()
    render(conn, :index, food_trucks: food_trucks)
  end

  def create(conn, %{"food_truck" => food_truck_params}) do
    with {:ok, %FoodTruck{} = food_truck} <- DataSF.create_food_truck(food_truck_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/food_trucks/#{food_truck}")
      |> render(:show, food_truck: food_truck)
    end
  end

  def show(conn, %{"id" => id}) do
    food_truck = DataSF.get_food_truck!(id)
    render(conn, :show, food_truck: food_truck)
  end

  def update(conn, %{"id" => id, "food_truck" => food_truck_params}) do
    food_truck = DataSF.get_food_truck!(id)

    with {:ok, %FoodTruck{} = food_truck} <- DataSF.update_food_truck(food_truck, food_truck_params) do
      render(conn, :show, food_truck: food_truck)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_truck = DataSF.get_food_truck!(id)

    with {:ok, %FoodTruck{}} <- DataSF.delete_food_truck(food_truck) do
      send_resp(conn, :no_content, "")
    end
  end
end