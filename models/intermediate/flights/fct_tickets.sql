{{
  config(
    materialized = 'table'
    )
}}

select 
    ticket_no,
    book_ref,
    passenger_id,
    passenger_name,
    contact_data
from
    {{ ref('stg_flights__tickets') }} A
where
    not exists (select 1 from {{ ref('staff') }} B where A.passenger_id = B.passenger_id)