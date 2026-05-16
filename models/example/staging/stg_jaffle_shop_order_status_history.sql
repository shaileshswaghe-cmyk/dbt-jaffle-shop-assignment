{{ config(materialized='view') }}

WITH source_order_status_history AS
(
    Select 
        ORDER_ID,
        STATUS,
        UPDATED_AT
    from
    {{source("jaffle_shop","ORDER_STATUS_HISTORY")}}
)
Select 
        ORDER_ID as orderid,
        STATUS as status,
        UPDATED_AT as updatedat
from
source_order_status_history