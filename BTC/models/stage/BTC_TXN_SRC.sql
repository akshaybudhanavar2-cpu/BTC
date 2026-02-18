{{ config(
  materialized = 'incremental',
  incremental_strategy = 'append'
) }}

SELECT
  *
FROM
  {{ source('STAGE', 'BTC_TXN') }}

{% if is_incremental() %}
WHERE
  block_timestamp > COALESCE(
    (
      SELECT
        MAX(block_timestamp)
      FROM
        {{ this }}
    ),
    '1900-01-01'
  )
{% endif %}
