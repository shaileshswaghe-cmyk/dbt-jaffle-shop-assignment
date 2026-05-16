{{ config(materialized='table') }}

with order_payments as (
    select 
        o.id as order_id,
        o.customerid as customer_id,
        o.orderdate,
        o.status,
        sum(p.amountindallor) as order_amount,
        count(p.id) as payment_count,
        listagg(p.paymentmethod, ',') as payment_methods
    from {{ ref('stg_jaffle_shop_orders') }} o
    left join {{ ref('stg_stripe_payments') }} p
        on o.id = p.orderid
    group by o.id, o.customerid, o.orderdate, o.status
)

select 
    order_id,
    customer_id,
    orderdate,
    status,
    order_amount,
    payment_count,
    payment_methods,
    current_timestamp as loaded_at
from order_payments
