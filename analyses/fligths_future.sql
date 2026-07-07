select
    scheduled_departure::date as date,
    count(*)
from
    {{ ref('fct_flights') }}
WHERE
    scheduled_departure::date >= '{{ run_started_at|string|truncate(10, True, "") }}'::date
GROUP BY
    scheduled_departure::date