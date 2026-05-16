{{ config(materialized='view', tags=["daily"]) }}

WITH source_customers AS
(
       SELECT 
            email,
            first_name,
            id,
            last_name,
            _loaded_at
       FROM   {{source('jaffle_shop','CUSTOMERS')}} 
) 
SELECT 
          EMAIL      AS email,
          FIRST_NAME AS firstname,
          ID         AS id,
          LAST_NAME  AS lastname,
          _LOADED_AT AS loadedat 
FROM   source_customers