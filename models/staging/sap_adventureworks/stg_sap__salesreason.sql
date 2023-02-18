with
    salesreason as (
        select
            salesreasonid as id_motivo_venda	
            , reasontype as tipo_motivo
        from {{ source('sap','salesreason') }}
    )
select *
from salesreason