with
    salesperson as (
        select
            businessentityid as id_entidade_negocio	
            , salesquota as cota_venda
            , bonus
            , commissionpct	as comissao
            , salesytd	as vendas_ano
            , saleslastyear as vendas_ultimo_ano
        from {{ source('sap','salesperson') }}
    )
select *
from salesperson	