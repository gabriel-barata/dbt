with base_economy as (

    SELECT
        _AIRBYTE_ECONOMY_HASHID,
        gdp_usd,
        location_key,
        gdp_per_capita_usd,
        human_capital_index
        
    FROM {{ source('raw_covid19', 'economy') }}

)

SELECT * FROM base_economy