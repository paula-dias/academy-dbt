with
    address as (
        select
            addressid as id_endereco
            , stateprovinceid as id_estado
            , addressline1 as endereco
            , city as nome_cidade
        from {{ source('sap','address') }}
    )
select *
from address