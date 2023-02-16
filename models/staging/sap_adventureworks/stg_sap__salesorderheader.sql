with
    salesorderheader as (
        select
            salesorderid as id_pedido_venda
            , customerid as id_cliente
            , salespersonid	as id_vendedor
            , territoryid as id_territorio
            , creditcardid as id_cartao_credito
            , orderdate as data_pedido
            , duedate as data_vencimento
            , shipdate as data_envio
            , status as status_compra
            , purchaseordernumber as numero_ordem_compra
            , subtotal
            , taxamt as taxa
            , freight as frete
            , totaldue as receita_total
        from {{ source('sap','salesorderheader') }}
    )
select *
from salesorderheader