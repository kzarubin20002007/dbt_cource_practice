{% set current_date = '{{ run_started_at|string|truncate(10, True, "") }}' %}
SELECT 
    count(*)
FROM
    {{ ref('fct_flights') }} ff
WHERE 
    ff.scheduled_departure::date
    between current_date - interval '10 years' and current_date