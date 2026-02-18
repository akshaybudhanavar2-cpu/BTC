SELECT
    output_address,
    SUM(output_amount) AS total_output_amount,
    COUNT(output_address) AS address_count
FROM
    {{ ref('BTC_ACTUAL_TRN') }}
WHERE
    output_amount > 10
GROUP BY
    output_address
