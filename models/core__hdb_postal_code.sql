{{ config(materialized='table') }}

with cte_final as (
    select postal,
       latitude,
       longtitude,
       searchval,
       blk_no,
       road_name,
       building,
       address
    from hdb_postal_code
)

select *
from cte_final
