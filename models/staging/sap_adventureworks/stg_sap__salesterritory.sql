with
    salesterritory as (
        select
            territoryid	as id_territorio
            , name as nome_territorio
            , countryregioncode as codigo_pais
        from {{ source('sap','salesterritory') }}
    )
select *
from salesterritory