{{ config(materialized='table') }}

with customer_orders as (
    select 
        c.id as customer_id,
        c.firstname,
        c.lastname,
        c.email,
        coalesce(count(o.id), 0) as total_orders,
        coalesce(sum(op.totalamountindallor), 0) as lifetime_spend
    from {{ ref('stg_jaffle_shop_customers') }} c
    left join {{ ref('stg_jaffle_shop_orders') }} o
        on c.id = o.customerid
    left join {{ ref('intermediate_order_payment')}} op
        on o.id = op.orderid
    group by c.id, c.firstname, c.lastname, c.email
)

select 
    customer_id,
    firstname,
    lastname,
    email,
    total_orders,
    lifetime_spend,
    current_timestamp as loaded_at
from customer_orders
