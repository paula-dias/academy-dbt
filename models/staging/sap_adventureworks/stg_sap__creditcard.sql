with
    creditcard as (
        select
            creditcardid as id_cartao_credito
            , cardtype as tipo_cartao
        from {{ source('sap','creditcard') }}
    )
select *
from creditcard