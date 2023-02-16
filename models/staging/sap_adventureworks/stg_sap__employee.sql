with
    employee as (
        select
            businessentityid as id_entidade_negocio
            , nationalidnumber as identificacao_nacional
            , jobtitle as funcao
        from {{ source('sap','employee') }}
    )
select *
from employee