with
    address as (
        select
            stateprovinceid as id_estado
            , city as nome_cidade
        from {{ source('sap','address') }}
    )
select *
from address