with base_index as (

    SELECT
        _AIRBYTE_INDEX_HASHID,
        place_id, 
        wikidata_id, 
        country_code,
        country_name,
        location_key, 
        locality_code, 
        locality_name, 
        datacommons_id, 
        subregion1_code, 
        subregion1_name, 
        subregion2_code, 
        subregion2_name, 
        aggregation_level, 
        iso_3166_1_alpha_2,
        iso_3166_1_alpha_3
    FROM {{ source('raw_covid19', 'index') }}

)

SELECT * FROM base_index