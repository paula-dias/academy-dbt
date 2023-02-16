with
    salesterritory as (
        select
            territoryid	as id_territorio
            , name as nome_territorio
            , countryregioncode as codigo_pais
            , salesytd as vendas_ano
            , saleslastyear as vendas_ultimo_ano
        from {{ source('sap','salesterritory') }}
    )
select *
from salesterritory