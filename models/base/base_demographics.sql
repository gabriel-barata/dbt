with base_demographics as (

    select *
    from {{ source('raw_covid19', 'demographics') }}

)

select * from base_demographics