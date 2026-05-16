{{ config(materialized='table') }}

WITH order_payment_aggregation as
(
    Select 
    A.id as orderid,
    SUM(B.amountindallor) as totalamountindallor,
    listagg(b.paymentmethod,',') listofpaymentmethod,
    count(1) as paymentcount,
    B.status as status
    from {{ ref("stg_jaffle_shop_orders")   }} as  A
    LEFT JOIN {{    ref("stg_stripe_payments")    }} as  B
    on A.id = B.orderid
    where B.status = 'success'
    group by  A.id,B.status
)
Select 
orderid,
totalamountindallor,
listofpaymentmethod,
paymentcount,
status,
current_timestamp as loadedat
from order_payment_aggregation


