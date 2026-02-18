with whale_alert AS (
  SELECT
    output_address,
    SUM(output_amount) AS total_output_amount,
    COUNT(output_address) AS address_count
FROM
    {{ ref('BTC_ACTUAL_TRN') }}
WHERE
    output_amount > 10
GROUP BY
    output_address ),

latest_price AS (
  SELECT
    price
  FROM
    {{ ref('btc_usd_max') }} 
    
    WHERE  to_date ( replace(snapped_at,'UTC','')) = current_date() )

select 
    wa.output_address,
    wa.total_output_amount,
    round(wa.total_output_amount * lp.price, 2) AS total_output_value_usd,
    wa.address_count
from whale_alert wa
cross join latest_price lp

