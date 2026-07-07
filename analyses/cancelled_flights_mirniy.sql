select
    scheduled_departure::date,
    count(*)
from
    {{ ref('fct_flights') }}
where
    departure_airport_id = 'MJZ'
    and status = 'Cancelled'
group by scheduled_departure::date
order by scheduled_departure::date