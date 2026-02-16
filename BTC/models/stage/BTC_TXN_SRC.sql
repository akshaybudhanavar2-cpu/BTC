{{
  config(
    materialized = 'incremental',
    unique_key = 'hash_key',
    incremental_strategy = 'append'
    )
}}

select * from {{ source('STAGE', 'BTC_TXN') }}
{% if is_incremental() %}
  where block_timestamp > (select max(block_timestamp) from {{ this }})
{% endif %}