defmodule FoodTrucksMap.DataSFTest do
  use FoodTrucksMap.DataCase

  alias FoodTrucksMap.DataSF

  describe "food_trucks" do
    alias FoodTrucksMap.DataSF.FoodTruck

    import FoodTrucksMap.DataSFFixtures

    @invalid_attrs %{address: nil, company: nil, food_items: nil, location_id: nil, type: nil}

    test "list_food_trucks/0 returns all food_trucks" do
      food_truck = food_truck_fixture()
      assert DataSF.list_food_trucks() == [food_truck]
    end

    test "get_food_truck!/1 returns the food_truck with given id" do
      food_truck = food_truck_fixture()
      assert DataSF.get_food_truck!(food_truck.id) == food_truck
    end

    test "create_food_truck/1 with valid data creates a food_truck" do
      valid_attrs = %{address: "some address", company: "some company", food_items: "some food_items", location_id: 42, type: "some type"}

      assert {:ok, %FoodTruck{} = food_truck} = DataSF.create_food_truck(valid_attrs)
      assert food_truck.address == "some address"
      assert food_truck.company == "some company"
      assert food_truck.food_items == "some food_items"
      assert food_truck.location_id == 42
      assert food_truck.type == "some type"
    end

    test "create_food_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DataSF.create_food_truck(@invalid_attrs)
    end

    test "update_food_truck/2 with valid data updates the food_truck" do
      food_truck = food_truck_fixture()
      update_attrs = %{address: "some updated address", company: "some updated company", food_items: "some updated food_items", location_id: 43, type: "some updated type"}

      assert {:ok, %FoodTruck{} = food_truck} = DataSF.update_food_truck(food_truck, update_attrs)
      assert food_truck.address == "some updated address"
      assert food_truck.company == "some updated company"
      assert food_truck.food_items == "some updated food_items"
      assert food_truck.location_id == 43
      assert food_truck.type == "some updated type"
    end

    test "update_food_truck/2 with invalid data returns error changeset" do
      food_truck = food_truck_fixture()
      assert {:error, %Ecto.Changeset{}} = DataSF.update_food_truck(food_truck, @invalid_attrs)
      assert food_truck == DataSF.get_food_truck!(food_truck.id)
    end

    test "delete_food_truck/1 deletes the food_truck" do
      food_truck = food_truck_fixture()
      assert {:ok, %FoodTruck{}} = DataSF.delete_food_truck(food_truck)
      assert_raise Ecto.NoResultsError, fn -> DataSF.get_food_truck!(food_truck.id) end
    end

    test "change_food_truck/1 returns a food_truck changeset" do
      food_truck = food_truck_fixture()
      assert %Ecto.Changeset{} = DataSF.change_food_truck(food_truck)
    end
  end
end
