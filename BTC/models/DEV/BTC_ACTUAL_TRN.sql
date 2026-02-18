{{ config(
  materialized = 'ephemeral',
) }}

SELECT
  *
FROM
  {{ ref('BTC_DEV') }}
WHERE
  is_coinbase = 'false'
