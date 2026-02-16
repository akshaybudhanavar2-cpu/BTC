{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'append'
    )
}}

with BTC_TXN_SRC as (
select * from {{ source('STAGE', 'BTC_TXN') }}
{% if is_incremental() %}
  where block_timestamp > (select max(block_timestamp) from {{ this }})
{% endif %} )
select * from BTC_TXN_SRC