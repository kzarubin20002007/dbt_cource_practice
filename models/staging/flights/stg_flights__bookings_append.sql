{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        tag = ['bookings']
    )
}}

select
    {{bookref_to_bigint('book_ref')}} as book_ref,
    book_date,
    {{ kopeck_to_ruble(column_name='total_amount') }} as total_amount,
    1 as some_amount

from 
    {{ source('demo_src', 'bookings') }}
{% if is_incremental() %}
where
    {{bookref_to_bigint('book_ref')}} > (select max({{bookref_to_bigint('book_ref')}}) from {{ this }})
{% endif %}