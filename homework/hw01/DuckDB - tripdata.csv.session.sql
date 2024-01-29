-- Path: DuckDB.session.sql
-- https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2024/01-docker-terraform/homework.md

select * from 'green_tripdata_2019-09.csv' limit 10;

CREATE TABLE green_tripdata 
AS SELECT * FROM 'green_tripdata_2019-09.csv';

select * from green_tripdata limit 10;

CREATE TABLE taxi_zone_lookup 
AS SELECT * FROM 'taxi+_zone_lookup.csv';

select * from taxi_zone_lookup limit 10;

-- 15612
select count(*) from green_tripdata
where 
	cast(lpep_pickup_datetime as date) >= '2019-09-18' 
	and cast(lpep_dropoff_datetime as date) <= '2019-09-18';

-- 2019-09-26T19:32:52.000Z
select lpep_pickup_datetime 
from green_tripdata 
where trip_distance = (select max(trip_distance) from green_tripdata);

-- Question 5. Three biggest pick up Boroughs
-- 'manhattan', 'brooklyn', 'queens
with slice as (
	select lpep_pickup_datetime, PULocationID
	from green_tripdata
	where cast(lpep_pickup_datetime as date) = '2019-09-18'
),

pickups as (
	select
		taxi_zone_lookup.Borough,
		count(*) as count_pickups
	from slice
	left join taxi_zone_lookup on slice.PULocationID = taxi_zone_lookup.LocationID
	group by taxi_zone_lookup.Borough
	order by count_pickups desc
	limit 3
)

-- Question 6. Largest tip

-- JFK Airport	62.31
-- Kips Bay	28.0
-- Upper West Side South	20.0
-- Woodside	30.0
-- NV	25.0

with zone_ as (
	select
		LocationID,
		Zone
	from taxi_zone_lookup
	where Zone = 'Astoria'
),
tips as (
	select * from green_tripdata
	where cast(lpep_pickup_datetime as date) < '2019-10-01'
	and cast(lpep_pickup_datetime as date) >= '2019-09-01'
),
largest_tips as (
	select DOLocationID, tip_amount from tips
	where PULocationID in (select LocationID from zone_)
	ORDER BY tip_amount DESC
	LIMIT 5
)
SELECT b."Zone", a."tip_amount" FROM largest_tips a
LEFT JOIN taxi_zone_lookup b ON a.DOLocationID = b.LocationID




