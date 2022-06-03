{{ config(materialized='table') }}

with cte_final as (
    select month,
       town,
       flat_type,
       block,
       street_name,
       storey_range,
       floor_area_sqm,
       flat_model,
       lease_commence_date,
       resale_price
    from resale_prices
)

select *
from cte_final
