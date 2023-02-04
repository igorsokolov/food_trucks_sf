# FoodTrucksMap

This repo is a simple Phoenix application to provide API endpoints about of Food Trucks in San Francisco. It uses [`public list`] (https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data) of Food Truck permits.

Initially the idea was to create map of San Francisco with food trucks marked on it and LiveView updates when bounds of map was changed. But due to time constrains and lack of necessary front-end development experience this project become a simple JSON API.

## Storage choises
To store and be able to query Geo information it was decided to use PostGIS extension for PostgreSQL. 
This will allow to run complext spacial queries on a dataset. We would need to add index on geo_location field if we expect to run fast queries on large dataset. 

## Data ingestion
The CSV file with a list of food trucks permits is parsed using seed.ex file. This file will be run after all migrations when using `mix setup` command. 
We filter out all records from the list that has status Requested or Expired, we also filter out records with no coordinates as we can't show it on the map. 

Ideally, if we had more time, we would use background jobs to fetch an up-to-date list periodically and update information in the database. This particular open data directory has and API and Elixir client wrapper (https://github.com/socrata/exsoda). 

## JSON API
JSON API has two endpoints : one for the list of all food trucks and another endpoint for showing information about specific food truck. Ideally, we would add pagination and provide a link of next page along the data of the current page. 

## What would be nice to have

- Periodic data update from the datasf website 
- The map (Google or Openstreetmap) with the marker for a food trucks. Here Leaflet.JS looks like a good candidate.
- LiveView map update on a change of a visible map bounds
- Ability to click on the map to set initial location and provide radius where to search for a food trucks
- Ability to extract food items into a searchable dataset. Although this information is unstructured, so it probavly would require manual curation. 
- Add locations based on a schedule using additional dataset provided by datasf website https://data.sfgov.org/Economy-and-Community/Mobile-Food-Schedule/jjew-r69b . This will allow to provide more specific location for the trucks that move location based on a time of day.

  
  
## Dependencies: 

PostgreSQL https://www.postgresql.org/download/
PostGIS https://postgis.net/install/
Elixir https://elixir-lang.org/install.html


To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
