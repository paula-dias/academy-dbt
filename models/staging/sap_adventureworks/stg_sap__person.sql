with
    person as (
        select
            businessentityid as id_entidade_negocio
            , concat(firstname , ' ', lastname) as nome_completo
        from {{ source('sap','person') }}
    )
select *
from person

