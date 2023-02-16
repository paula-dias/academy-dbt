with
    countryregion as (
        select
            countryregioncode as codigo_pais
            , name as nome_pais
        from {{ source('sap','countryregion') }}
    )
select *
from countryregion