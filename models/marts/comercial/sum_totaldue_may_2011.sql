/* If sum of receita_total in May-2011 is not 567020.9498, throws an error */

with
    sum_receita_total as (
        select
            sum(receita_total) as cnt
        from {{ ref ('fct_salesorder') }}
        where data_pedido
        between '2011-05-01' and '2011-05-31'
    )
select * from sum_receita_total where cnt != 567020.9498