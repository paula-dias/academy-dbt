with
    salesorderdetail as (
        select
            salesorderid as id_pedido_venda
            , productid	as id_produto
            , orderqty as quantidade_pedido
            , unitprice	as preco_unitario
            , unitpricediscount	as desconto_preco_unitario
        from {{ source('sap','salesorderdetail') }}
    )
select *
from salesorderdetail
			
		
			
		
		
