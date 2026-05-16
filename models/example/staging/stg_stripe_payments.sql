{{ config(materialized='view') }}

WITH source_payments AS
(
    Select 
    AMOUNT,
    CREATED_AT,
    ID,
    ORDER_ID,
    PAYMENT_METHOD,
    STATUS
    from {{source("stripe","PAYMENTS")}}
)
Select
    AMOUNT as amountincents,
    AMOUNT/100 as amountindallor,
    CREATED_AT as createdat,
    ID as id,
    ORDER_ID as orderid,
    PAYMENT_METHOD as paymentmethod,
    STATUS as status
from source_payments