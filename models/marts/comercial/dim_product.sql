with
    produto as (
        select
            id_produto
            , nome_produto
            , numero_produto
            , custo_padrao
            , preco_tabela
            , linha_produto
            , classe
            , estilo
        from {{ ref('stg_sap__product') }}
    )

    , transformacoes as (
        select
            row_number() over (order by id_produto) as sk_produto
            , *
        from produto
    )

select *
from transformacoes