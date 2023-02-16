with
    pedido_razao as (
        select
            id_pedido_venda
            , id_motivo_venda
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )

    , motivo_venda as (
        select
            id_motivo_venda
            , nome_motivo
            , tipo_motivo
        from {{ ref('stg_sap__salesreason') }}
    )

    , tabela_resultante as (
        select
            pedido_razao.id_pedido_venda
            , pedido_razao.id_motivo_venda
            , motivo_venda.nome_motivo
            , motivo_venda.tipo_motivo
        from pedido_razao
        left join motivo_venda on pedido_razao.id_motivo_venda = motivo_venda.id_motivo_venda
    )

    , transformacoes as (
        select
            row_number() over (order by id_motivo_venda) as sk_motivo_venda
            , *
        from tabela_resultante
    )

select *
from transformacoes