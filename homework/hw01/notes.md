# Homework 01


## Question 1. Docker tags

```bash
docker run --rm
```

# Question 2. Docker run: version of wheel

```bash
docker run --rm -it python:3.9 python -m pip list | grep wheel
```

# Question 3. Count records

```sql
-- Path: trips_data.duckdb
-- https://github.com/DataT	alksClub/data-engineering-zoomcamp/blob/main/cohorts/2024/01-docker-terraform/homework.md

CREATE TABLE green_tripdata 
AS SELECT  FROM 'green_tripdata_2019-09.csv';

select  from green_tripdata limit 10;

CREATE TABLE taxi_zone_lookup 
AS SELECT FROM 'taxi+_zone_lookup.csv';

select * from taxi_zone_lookup limit 10;
```

## Question 3. Count records

```sql
-- 15612
select count(*) from green_tripdata
where 
    cast(lpep_pickup_datetime as date) >= '2019-09-18' 
    and cast(lpep_dropoff_datetime as date) <= '2019-09-18';
```


## Question 4. Largest trip for each day

```sql
-- 2019-09-26T19:32:52.000Z
select lpep_pickup_datetime 
from green_tripdata 
where trip_distance = (select max(trip_distance) from green_tripdata);
```


## Question 5. Three biggest pick up Boroughs

```sql
-- 'manhattan', 'brooklyn', 'queens
with slice as (
    select lpep_pickup_datetime, PULocationID
    from green_tripdata
    where cast(lpep_pickup_datetime as date) = '2019-09-18'
),

pickups as (
    select
        taxi_zone_lookup.Borough,
        count() as count_pickups
    from slice
    left join taxi_zone_lookup on slice.PULocationID = taxi_zone_lookup.LocationID
    group by taxi_zone_lookup.Borough
    order by countpickups desc
    limit 3
)
```

## Question 6. Largest tip

```sql
-- JFK Airport	62.31
-- Kips Bay	28.0
-- Upper West Side South	20.0
-- Woodside	30.0
-- NV	25.0

with zone as (
    select
        LocationID,
        Zone
    from taxi_zone_lookup
    where Zone = 'Astoria'
),
tips as (
    select  from green_tripdata
    where cast(lpep_pickup_datetime as date) < '2019-10-01'
    and cast(lpep_pickup_datetime as date) >= '2019-09-01'
),
largest_tips as (
    select DOLocationID, tip_amount from tips
    where PULocationID in (select LocationID from zone_)
    order by tip_amount desc
    limit 5
)
select b."Zone", a."tip_amount" from largest_tips a
left join taxi_zone_lookup b on a.DOLocationID = b.LocationID
```

## 7. terraform

```bash
$ terraform apply

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_storage_bucket.demo-bucket will be created
  + resource "google_storage_bucket" "demo-bucket" {
      + effective_labels            = (known after apply)
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "US"
      + name                        = "terraform-demo-412321-terraform-bucket"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + rpo                         = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + terraform_labels            = (known after apply)
      + uniform_bucket_level_access = (known after apply)
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "AbortIncompleteMultipartUpload"
            }
          + condition {
              + age                   = 1
              + matches_prefix        = []
              + matches_storage_class = []
              + matches_suffix        = []
              + with_state            = (known after apply)
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:    
```