with
    cartao_credito as (
        select *
        from {{ ref('dim_creditcard') }}
    )
    , cliente as (
        select *
        from {{ ref('dim_customer') }}
    )
    , vendedor as (
        select *
        from {{ ref('dim_salesperson') }}
    )
    , motivo_venda as (
        select *
        from {{ ref('dim_salesreason') }}
    )
    , territorio as (
        select *
        from {{ ref('dim_territory') }}
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
    , joined as (
        select
            cabecalho_pedido_venda.id_pedido_venda
            , cartao_credito.sk_cartao_credito as fk_cartao_credito
            , cliente.sk_cliente as fk_cliente
            , vendedor.sk_vendedor as fk_vendedor
            , motivo_venda.sk_motivo_venda as fk_motivo_venda
            , territorio.sk_territorio as fk_territorio
            , cabecalho_pedido_venda.data_pedido
            , cabecalho_pedido_venda.data_vencimento
            , cabecalho_pedido_venda.data_envio
            , cabecalho_pedido_venda.status_compra
            , cabecalho_pedido_venda.numero_ordem_compra
            , cabecalho_pedido_venda.subtotal
            , cabecalho_pedido_venda.taxa
            , cabecalho_pedido_venda.frete
            , cabecalho_pedido_venda.receita_total
        from cabecalho_pedido_venda
        left join cartao_credito on cabecalho_pedido_venda.id_cartao_credito = cartao_credito.id_cartao_credito
        left join cliente on cabecalho_pedido_venda.id_cliente = cliente.id_cliente
        left join vendedor on cabecalho_pedido_venda.id_vendedor = vendedor.id_entidade_negocio
        left join territorio on cabecalho_pedido_venda.id_territorio = territorio.id_territorio
        right join motivo_venda on cabecalho_pedido_venda.id_pedido_venda = motivo_venda.id_pedido_venda
    )

    , transformacoes as (
        select
            row_number() over (order by id_pedido_venda) as sk_pedido_venda
            , *
        from joined
    )

select *
from transformacoes
