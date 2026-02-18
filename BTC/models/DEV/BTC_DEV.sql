{{ config(
  materialized = 'incremental',
  incremental_strategy = 'append'
) }}

WITH btc_dev AS (

  SELECT
    b.*,
    t.value :address :: STRING AS output_address,
    t.value :value :: NUMBER AS output_amount
  FROM
    {{ ref('BTC_TXN_SRC') }}
    b,
    LATERAL FLATTEN(
      input => b.outputs
    ) t
  WHERE
    t.value :address IS NOT NULL
)
SELECT
  *
FROM
  btc_dev

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
