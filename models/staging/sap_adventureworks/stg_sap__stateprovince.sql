with
    stateprovince as (
        select
            stateprovinceid as id_estado
            , stateprovincecode as codigo_estado
            , countryregioncode as codigo_pais
            , name as nome_estado
            , territoryid as id_territorio
        from {{ source('sap','stateprovince') }}
    )
select *
from stateprovince