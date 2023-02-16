with
    vendedor as (
        select
            id_entidade_negocio	
            , cota_venda
            , bonus
            , comissao
            , vendas_ano
            , vendas_ultimo_ano
        from {{ ref('stg_sap__salesperson') }}
    )

    , informacao_pessoal as (
        select
            id_entidade_negocio
            , nome_completo
        from {{ ref('stg_sap__person') }}
    )

    , vendedor_informacao as (
        select
            vendedor.id_entidade_negocio
            , vendedor.cota_venda
            , vendedor.bonus
            , vendedor.comissao
            , vendedor.vendas_ano
            , vendedor.vendas_ultimo_ano
            , informacao_pessoal.nome_completo
        from informacao_pessoal
        right join vendedor on informacao_pessoal.id_entidade_negocio = vendedor.id_entidade_negocio
    )

    , funcionario as (
        select
            id_entidade_negocio
            , identificacao_nacional
            , funcao
        from {{ ref('stg_sap__employee') }}
    )

    , tabela_final as (
        select
            vendedor_informacao.id_entidade_negocio
            , vendedor_informacao.cota_venda
            , vendedor_informacao.bonus
            , vendedor_informacao.comissao
            , vendedor_informacao.vendas_ano
            , vendedor_informacao.vendas_ultimo_ano
            , vendedor_informacao.nome_completo
            , funcionario.identificacao_nacional
            , funcionario.funcao
        from funcionario
        right join vendedor_informacao on funcionario.id_entidade_negocio = vendedor_informacao.id_entidade_negocio
    )

    , transformacoes as (
        select
            row_number() over (order by id_entidade_negocio) as sk_vendedor
            , *
        from tabela_final
    )

select *
from transformacoes