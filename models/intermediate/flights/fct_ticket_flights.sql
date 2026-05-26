{{
  config(
    materialized = 'table'
    )
}}

select 
    ft.ticket_no,
    ft.flight_id,
    ft.fare_conditions,
    ft.amount,
    case when bp.boarding_no is null then 'no'
        else 'yes'
    end as boarding_pass_exists,
    bp.boarding_no,
    bp.seat_no,
    current_date as load_date
from
    {{ ref('stg_flights__ticket_flights') }} as ft
left join
    {{ ref('stg_flights__boarding_passes') }} as bp
using
    (ticket_no, flight_id)