{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        on_schema_change = 'fail',
        tag = ['bookings']
    )
}}

select
    book_ref,
    book_date,
    total_amount::int,
    1 as some_amount

from 
    {{ source('demo_src', 'bookings') }}
{% if is_incremental() %}
where
    ('0x' || book_ref)::bigint > (select max(('0x' || book_ref)::bigint) from {{ this }})
{% endif %}