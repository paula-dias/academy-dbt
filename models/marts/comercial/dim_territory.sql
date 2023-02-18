with
    cidade as (
        select
            id_estado
            , nome_cidade
        from {{ ref('stg_sap__address') }}
    )

    , estado as (
        select
            id_estado
            , codigo_estado
            , codigo_pais
            , nome_estado
            , id_territorio
        from {{ ref('stg_sap__stateprovince') }}
    )

    , cidade_estado as (
        select
            cidade.id_estado
            , estado.id_territorio
            , cidade.nome_cidade
            , estado.codigo_estado
            , estado.codigo_pais
            , estado.nome_estado
        from estado
        left join cidade on estado.id_estado = cidade.id_estado
    )

    , pais as (
        select
            codigo_pais
            , nome_pais
        from {{ ref('stg_sap__countryregion') }}
    )

    , localizacao as (
        select
            pais.codigo_pais
            , cidade_estado.id_estado
            , cidade_estado.id_territorio
            , pais.nome_pais
            , cidade_estado.nome_cidade
            , cidade_estado.codigo_estado
            , cidade_estado.nome_estado
        from pais
        left join cidade_estado on pais.codigo_pais = cidade_estado.codigo_pais
    )

    , venda_territorio as (
        select
            id_territorio
            , nome_territorio
            , codigo_pais
        from {{ ref('stg_sap__salesterritory') }}
    )

    , localizacao_venda as (
        select distinct
            venda_territorio.id_territorio
            , localizacao.id_estado
            , venda_territorio.nome_territorio
            , venda_territorio.codigo_pais
            , localizacao.nome_cidade
            , localizacao.codigo_estado
            , localizacao.nome_estado
            , localizacao.nome_pais
        from venda_territorio
        left join localizacao on venda_territorio.id_territorio = localizacao.id_territorio
    )

    , transformacoes as (
        select distinct
            row_number() over (order by id_territorio) as sk_territorio
            , *
        from localizacao_venda
    )

select *
from transformacoes