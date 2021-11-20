select nome_remedio, tratamento
from remedio;

select  ve.nome_veterinario ,a.nome_animal
from    veterinario as ve,
        animal as a,
        vacinacao as va
where   ve.crmv_veterinario=204
        and va.crmv_veterinario=ve.crmv_veterinario
        and a.id_animal = va.id_animal
        and va.data between '2018-01-01' and '2018-12-31'
        and a.sexo = 'F';


select  ve.nome_veterinario ,a.nome_animal
from    veterinario as ve,
        animal as a,
        vacinacao as va
where   ve.crmv_veterinario=9905
        and va.crmv_veterinario=ve.crmv_veterinario
        and a.id_animal = va.id_animal
        and va.data between '2018-01-01' and '2018-12-31'
        and a.sexo = 'M';

select count (a.id_animal) as quantidade
from animal as a;

select  a.nome_animal, l.litros
from    leite as l,
        animal as a
where   l.id_animal = a.id_animal
        and l.data='2018-06-10';

select data, preco / quantidade as valor_litro
        from lote
        group by data, quantidade, preco;

select id_cliente, SUM(preco)
        from venda as v, lote as l
        where l.id_lote = v.id_lote and id_cliente = id_cliente
        group by id_cliente;

select uf, SUM(preco)
        from venda as v, lote as l, cliente as c
        where l.id_lote = v.id_lote and v.id_cliente = c.id_cliente and uf = 'MG'
        group by uf;

select avg(litros)
        from leite;

create temporary table vaca_remedio as
        select a.id_animal, nome_animal, nome_remedio
        from aplicacao_remedio as ar, remedio as r, animal as a
        where r.id_remedio = ar.id_remedio and ar.id_animal = a.id_animal    
        group by a.id_animal, nome_animal, nome_remedio;

select vr.nome_remedio, a.nome_animal
        from vaca_remedio as vr
        left join animal as a
        on a.id_animal = vr.id_animal;

select vr.nome_remedio, a.nome_animal
        from vaca_remedio as vr
        right join animal as a
        on a.id_animal = vr.id_animal where nome_remedio is null;



