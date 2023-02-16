with
    customer as (
        select
            customerid as id_cliente
            , personid as id_informacao_pessoal
        from {{ source('sap','customer') }}
    )
select *
from customer
