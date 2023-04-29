{{ config(materialized = 'table') }}

with epidemiology as (

    SELECT *
    FROM {{ ref('base_epidemiology') }}

),
demographics as (

    SELECT *
    FROM {{ ref('base_demographics') }}

),
economy ec as (

    SELECT *
    FROM {{ ref('base_economy') }}

),
index as (

    SELECT *
    FROM {{ ref('base_index') }}

),
epidemiology_join as (

    SELECT
        ep.date,
        ep.location_key,
        iff(ep.new_confirmed = 'NaN', 0, ep.new_confirmed) as new_confirmed,
        iff(ep.new_deceased = 'NaN', 0, ep.new_deceased) as new_deceased,
        iff(ep.new_recovered = 'NaN', 0, ep.new_recovered) as new_recovered,
        iff(ep.cumulative_confirmed = 'NaN', 0, ep.cumulative_confirmed) as cumulative_confirmed,
        iff(ep.cumulative_decesead = 'NaN', 0, ep.cumulative_deceased) as cumulative_deceased,
        iff(ep.cumulative_recovered = 'NaN', 0, ep.cumulative_recovered) as cumulative_recovered,
        iff(ep.cumulative_tested = 'NaN', 0, ep.cumulative_tested) as cumulative_tested,
        ec.gdp_usd,
        ec.gdp_per_capita_usd,
        ec.human_capital_index,
        dm.population,
        dm.population_male,
        dm.population_female,
        dm.population_rural,
        dm.population_urban,
        dm.opulation_largest_city,
        dm.population_clustered,
        dm.population_density,
        dm.human_development_index,
        dm.population_age_00_09,
        dm.population_age_10_19,
        dm.population_age_20_29,
        dm.population_age_30_39,
        dm.population_age_40_49,
        dm.population_age_50_59,
        dm.population_age_60_69,
        dm.population_age_70_79,
        dm.population_age_80_and_older,
        index.place_id, 
        index.wikidata_id, 
        index.country_code,
        index.country_name,
        index.locality_code, 
        index.locality_name, 
        index.datacommons_id, 
        index.subregion1_code, 
        index.subregion1_name, 
        index.subregion2_code, 
        index.subregion2_name, 
        index.aggregation_level, 
        index.iso_3166_1_alpha_2,
        index.iso_3166_1_alpha_3

    FROM epidemiology ep
    LEFT JOIN demographics dm ON ep.location_key = dm.location_key
    LEFT JOIN economy ec ON ep.location_key = ec.location_key
    LEFT JOIN index ON ep.location_key = index.location_key

)

SELECT * FROM epidemiology_join