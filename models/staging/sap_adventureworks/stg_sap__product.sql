with
    product as (
        select
            productid as id_produto
            , name as nome_produto
            , productnumber	as numero_produto
            , standardcost	as custo_padrao
            , listprice	as preco_tabela
            , productline as linha_produto
            , class	as classe
            , style	as estilo						
        from {{ source('sap','product') }}
    )
select *
from product
		
		
			
			
			
