{% set current_date = run_started_at.strftime("%Y-%m-%d") %}

select t.$1:hash AS hashkey,
    t.$1:block_hash as block_hash,
    t.$1:block_number as block_number,
    t.$1:block_timestamp as block_timestamp,
    t.$1:fee as fee,
    t.$1:input_value as input_value,
    t.$1:output_value AS output_btc,
    ROUND(t.$1:fee / t.$1:size, 12) AS fee_per_byte,
    t.$1:is_coinbase as is_coinbase,
    t.$1:outputs AS outputs_btc
from @AWS_BTC_STAGE/transactions/date={{ current_date }}/ t
WHERE metadata$filename RLIKE '.*/[0-9]{6,7}[.]snappy[.]parquet'