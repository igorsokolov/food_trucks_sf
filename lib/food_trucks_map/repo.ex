defmodule FoodTrucksMap.Repo do
  use Ecto.Repo,
    otp_app: :food_trucks_map,
    adapter: Ecto.Adapters.Postgres
end
