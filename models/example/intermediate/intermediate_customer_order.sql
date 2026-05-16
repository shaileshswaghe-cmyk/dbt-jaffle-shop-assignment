{{ config(materialized='table') }}

WITH customerorders AS
(
    SELECT 
        A.ID AS CUSTOMERID,
        A.FIRSTNAME AS FIRSTNAME,
        A.LASTNAME AS LASTNAME,
        MIN(orderdate) AS FIRST_ORDER_DATE,
        MAX(orderdate) AS MOST_RECENT_ORDER_DATE,
        COUNT(B.ID) AS TOTAL_ORDER_COUNT
    FROM {{ ref("stg_jaffle_shop_customers")    }} A
    LEFT JOIN {{    ref("stg_jaffle_shop_orders")   }} B
    ON A.ID = b.CUSTOMERID
    GROUP BY  A.ID, A.FIRSTNAME, A.lastname
)
SELECT
    CUSTOMERID,
    FIRSTNAME,
    LASTNAME,
    FIRST_ORDER_DATE as firstorderdate,
    MOST_RECENT_ORDER_DATE as mostrecentorderdate,
    TOTAL_ORDER_COUNT as totalordercount,
    current_timestamp as loadedat
FROM customerorders
