# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodTrucksMap.Repo.insert!(%FoodTrucksMap.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Parser do
  alias FoodTrucksMap.DataSF
  def convert_to_map_list([{:ok, header_row} | data_tuples]) do
    Enum.map(data_tuples, fn {_, data} ->
      header_row |> Enum.zip(data) |> Enum.into(%{})
    end)
  end

  def ingest_record(permit) do
    %{
      location_id:  String.to_integer(permit["locationid"]),
      address:      permit["Address"],
      company:      permit["Applicant"],
      food_items:   permit["FoodItems"],
      type:         permit["FacilityType"],
      geo_location: %Geo.Point{
                      coordinates: {
                        String.to_float(permit["Longitude"]),
                        String.to_float(permit["Latitude"])
                      }
                    }
    }
    |> DataSF.create_food_truck()
  end
end

FoodTrucksMap.Repo.delete_all(FoodTrucksMap.DataSF.FoodTruck)

File.stream!("#{__DIR__}/data/Mobile_Food_Facility_Permit.csv")
|> CSV.decode()
|> Enum.to_list()
|> Parser.convert_to_map_list()
|> Enum.filter(fn permit ->
    permit["Status"] == "APPROVED"
    and permit["Latitude"] != "0"
    and permit["Longitude"] != "0"
end)
|> Enum.map(&Parser.ingest_record/1)
