{{ config(materialized='view') }}

WITH source_orders AS
(
    Select
        CUSTOMER_ID,
        ID,
        ORDER_DATE,
        STATUS,
        _LOADED_AT
    FROM
    {{source("jaffle_shop","ORDERS")}}
)
Select
        CUSTOMER_ID as customerid,
        ID as id,
        ORDER_DATE as orderdate,
        STATUS as status,
        _LOADED_AT as loadedat
from
source_orders