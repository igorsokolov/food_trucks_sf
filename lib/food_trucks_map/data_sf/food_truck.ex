defmodule FoodTrucksMap.DataSF.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_trucks" do
    field :address, :string
    field :company, :string
    field :food_items, :string
    field :location_id, :integer
    field :type, :string
    field :geo_location, Geo.PostGIS.Geometry

    timestamps()
  end

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [:location_id, :company, :type, :address, :food_items, :geo_location])
    |> validate_required([:location_id, :company, :type, :address, :food_items, :geo_location])
  end
end
