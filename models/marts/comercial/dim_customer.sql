with
    cliente as (
        select
            id_cliente
            , id_informacao_pessoal
        from {{ ref('stg_sap__customer') }}
    )

    , informacao_pessoal as (
        select
            id_entidade_negocio
            , nome_completo
        from {{ ref('stg_sap__person') }}
    )

    , cliente_informacao as (
        select
            cliente.id_cliente
            , cliente.id_informacao_pessoal
            , informacao_pessoal.nome_completo
        from informacao_pessoal
        right join cliente on informacao_pessoal.id_entidade_negocio = cliente.id_informacao_pessoal
    )

    , transformacoes as (
        select
            row_number() over (order by id_cliente) as sk_cliente
            , *
        from cliente_informacao
    )

select *
from transformacoes
