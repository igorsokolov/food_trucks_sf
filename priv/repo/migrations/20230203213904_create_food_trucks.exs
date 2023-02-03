defmodule FoodTrucksMap.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def change do
    create table(:food_trucks) do
      add :location_id, :integer
      add :company, :string
      add :type, :string
      add :address, :string
      add :food_items, :string
      add :geo_location, :geometry

      timestamps()
    end
  end
end
