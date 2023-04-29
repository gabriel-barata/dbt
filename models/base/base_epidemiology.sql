with base_epidemiology as (

    SELECT
        _AIRBYTE_EPIDEMIOLOGY_HASHID,
        date,
        location_key,
        new_confirmed,
        new_deceased,
        new_recovered,
        new_tested,
        cumulative_confirmed,
        cumulative_deceased,
        cumulative_recovered,
        cumulative_tested 
    FROM {{ source('raw_covid19', 'epidemiology') }}

)

SELECT * FROM base_epidemiology