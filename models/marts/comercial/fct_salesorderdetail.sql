with
    produto as (
        select *
        from {{ ref('dim_product') }}
    )
    , detalhe_ordem_pedido as (
        select
            id_pedido_venda
            , id_produto
            , quantidade_pedido
            , preco_unitario
            , desconto_preco_unitario
        from {{ ref('stg_sap__salesorderdetail') }}
    )
    , uniao_tabelas as (
        select
            detalhe_ordem_pedido.id_pedido_venda
            , produto.sk_produto as fk_produto
            , detalhe_ordem_pedido.quantidade_pedido
            , detalhe_ordem_pedido.preco_unitario
            , detalhe_ordem_pedido.desconto_preco_unitario
        from detalhe_ordem_pedido
        left join produto on detalhe_ordem_pedido.id_produto = produto.id_produto
    )
    , ordem_vendas as (
        select
            id_pedido_venda
            , sk_pedido_venda
        from {{ ref('fct_salesorder') }}
    )
    , tabela_final as (
        select
            ordem_vendas.sk_pedido_venda as fk_pedido_venda
            , uniao_tabelas.fk_produto
            , uniao_tabelas.quantidade_pedido
            , uniao_tabelas.preco_unitario
            , uniao_tabelas.desconto_preco_unitario
        from uniao_tabelas
        left join ordem_vendas on uniao_tabelas.id_pedido_venda = ordem_vendas.id_pedido_venda
    )
    , transformacoes as (
        select
            row_number() over (order by fk_pedido_venda, fk_produto) as sk_pedido_venda_produto
            , *
        from tabela_final
    )

select *
from transformacoes