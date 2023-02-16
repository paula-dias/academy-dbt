with
    salesorderheadersalesreason as (
        select
            salesorderid as id_pedido_venda
            , salesreasonid as id_motivo_venda
        from {{ source('sap','salesorderheadersalesreason') }}
    )
select *
from salesorderheadersalesreason