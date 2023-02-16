with
    cartao_credito as (
        select *
        from {{ ref('dim_creditcard') }}
    )

    , cliente as (
        select *
        from {{ ref('dim_customer') }}
    )

    , produto as (
        select *
        from {{ ref('dim_product') }}
    )

    , vendedor as (
        select *
        from {{ ref('dim_salesperson') }}
    )

    , motivo_venda as (
        select *
        from {{ ref('dim_salesreason') }}
    )

    , venda_territorio as (
        select *
        from {{ ref('dim_salesterritory') }}
    )

    , cabecalho_pedido_venda as (
        select
            id_pedido_venda
            , id_cliente
            , id_vendedor
            , id_territorio
            , id_cartao_credito
            , data_pedido
            , data_vencimento
            , data_envio
            , status_compra
            , numero_ordem_compra
            , subtotal
            , taxa
            , frete
            , receita_total
        from {{ ref('stg_sap__salesorderheader') }}
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

    , pedido_venda_completo as (
        select
            cabecalho_pedido_venda.id_pedido_venda
            , cabecalho_pedido_venda.id_cliente
            , cabecalho_pedido_venda.id_vendedor
            , cabecalho_pedido_venda.id_territorio
            , cabecalho_pedido_venda.id_cartao_credito
            , detalhe_ordem_pedido.id_produto
            , cabecalho_pedido_venda.data_pedido
            , cabecalho_pedido_venda.data_vencimento
            , cabecalho_pedido_venda.data_envio
            , cabecalho_pedido_venda.status_compra
            , cabecalho_pedido_venda.numero_ordem_compra
            , cabecalho_pedido_venda.subtotal
            , cabecalho_pedido_venda.taxa
            , cabecalho_pedido_venda.frete
            , cabecalho_pedido_venda.receita_total
            , detalhe_ordem_pedido.quantidade_pedido
            , detalhe_ordem_pedido.preco_unitario
            , detalhe_ordem_pedido.desconto_preco_unitario
        from cabecalho_pedido_venda
        left join detalhe_ordem_pedido on cabecalho_pedido_venda.id_pedido_venda = detalhe_ordem_pedido.id_pedido_venda
    )

    , joined as (
        select
           pedido_venda_completo.id_pedido_venda
           , cartao_credito.sk_cartao_credito as fk_cartao_credito
           , cliente.sk_cliente as fk_cliente
           , produto.sk_produto as fk_produto
           , vendedor.sk_vendedor as fk_vendedor
           , motivo_venda.sk_motivo_venda as fk_motivo_venda
           , venda_territorio.sk_venda_territorio as fk_venda_territorio
           , pedido_venda_completo.data_pedido
           , pedido_venda_completo.data_vencimento
           , pedido_venda_completo.data_envio
           , pedido_venda_completo.status_compra
           , pedido_venda_completo.numero_ordem_compra
           , pedido_venda_completo.subtotal
           , pedido_venda_completo.taxa
           , pedido_venda_completo.frete
           , pedido_venda_completo.receita_total
           , pedido_venda_completo.quantidade_pedido
           , pedido_venda_completo.preco_unitario
           , pedido_venda_completo.desconto_preco_unitario
        from pedido_venda_completo
        left join cartao_credito on pedido_venda_completo.id_cartao_credito = cartao_credito.id_cartao_credito
        left join cliente on pedido_venda_completo.id_cliente = cliente.id_cliente
        left join produto on pedido_venda_completo.id_produto = produto.id_produto
        left join vendedor on pedido_venda_completo.id_vendedor = vendedor.id_entidade_negocio
        left join venda_territorio on pedido_venda_completo.id_territorio = venda_territorio.id_territorio
        left join motivo_venda on pedido_venda_completo.id_pedido_venda = motivo_venda.id_pedido_venda
    )

    , transformacoes as (
        select
            row_number() over (order by id_pedido_venda) as sk_pedido_venda
            , *
        from joined
    )

select *
from transformacoes
