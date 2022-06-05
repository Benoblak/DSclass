{{ config(materialized='table') }}

with cte_postal as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       road_name,
       building,
       address
from {{ref('core__hdb_postal_code')}}
),

cte_drive as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       road_name as original_road_name,
       replace(road_name,'DRIVE','DR') as road_name,
       building,
       address
from cte_postal
),

cte_crescent as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'CRESCENT','CRES') as road_name,
       building,
       address
from cte_drive
),

cte_road as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'ROAD','RD') as road_name,
       building,
       address
from cte_crescent
),

cte_avenue as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'AVENUE','AVE') as road_name,
       building,
       address
from cte_road
),

cte_jalan as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'JALAN','JLN') as road_name,
       building,
       address
from cte_avenue
),

cte_close as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'CLOSE','CL') as road_name,
       building,
       address
from cte_jalan
),

cte_cwealth as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'COMMONWEALTH',$$C'WEALTH$$) as road_name,
       building,
       address
from cte_close
),

cte_sth as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'SOUTH','STH') as road_name,
       building,
       address
from cte_cwealth
),

cte_loring as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'LORONG','LOR') as road_name,
       building,
       address
from cte_sth
),

cte_terrace as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'TERRACE','TER') as road_name,
       building,
       address
from cte_loring
),

cte_upper as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'UPPER','UPP') as road_name,
       building,
       address
from cte_terrace
),

cte_katong as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'KATONG','KG') as road_name,
       building,
       address
from cte_upper
),

cte_tanjong as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'TANJONG','TG') as road_name,
       building,
       address
from cte_katong
),

cte_north as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'NORTH','NTH') as road_name,
       building,
       address
from cte_tanjong
),

cte_park as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'PARK','PK') as road_name,
       building,
       address
from cte_north
),

cte_bukit as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'BUKIT','BT') as road_name,
       building,
       address
from cte_park
),

cte_street as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'STREET','ST') as road_name,
       building,
       address
from cte_bukit
),

cte_central as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       replace(road_name,'CENTRAL','CTRL') as road_name,
       building,
       address
from cte_street
),

cte_final as (
select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       original_road_name,
       road_name,
       building,
       address
from cte_central
)

select * from cte_final