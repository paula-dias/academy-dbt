with
    cartao_credito as (
        select
            id_cartao_credito
            , tipo_cartao
        from {{ ref('stg_sap__creditcard') }}
    )

    , transformacoes as (
        select
            row_number() over (order by id_cartao_credito) as sk_cartao_credito
            , *
        from cartao_credito
    )

select *
from transformacoes