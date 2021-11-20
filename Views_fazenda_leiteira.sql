--Retornar o nome dos remédios e seus respectivos tratamentos--
create view nome_remedio as
select nome_remedio, tratamento
from remedio;

--Mostrar os animais que foram vacinados pelos veterinario TÂNIA LINO FIUZA no ano de 2018 tirando os machos--
create view tania_aplicacao  as
select  ve.nome_veterinario ,a.nome_animal
from    veterinario as ve,
        animal as a,
        vacinacao as va
where   ve.crmv_veterinario=204
        and va.crmv_veterinario=ve.crmv_veterinario
        and a.id_animal = va.id_animal
        and va.data between '2018-01-01' and '2018-12-31'
        and a.sexo = 'F';

--Mostrar os animais que foram vacinados pelos veterinario EDUARDO NUNES AMARANTE no ano de 2018 tirando as fêmeas--
create view eduardo_vacina as
select  ve.nome_veterinario ,a.nome_animal
from    veterinario as ve,
        animal as a,
        vacinacao as va
where   ve.crmv_veterinario=9905
        and va.crmv_veterinario=ve.crmv_veterinario
        and a.id_animal = va.id_animal
        and va.data between '2018-01-01' and '2018-12-31'
        and a.sexo = 'M';

--Contar a quantidade de animais que possue a fazenda--
create view animais_fazenda as
select count (a.id_animal) as quantidade
from animal as a;

--Retornar a quantidade de litros produzido na data 2018-06-10 e o nome do animal referente a essa data--
create view leite_dez_de_junho as
select  a.nome_animal, l.litros
from    leite as l,
        animal as a
where   l.id_animal = a.id_animal
        and l.data='2018-06-10';

--Preço do litro de leite por data--
create view preco_leite_diario as
select data, preco / quantidade as valor_litro
        from lote
        group by data, quantidade, preco;

--Valor total comprado por cada cliente--
create view compra_cliente as
select id_cliente, SUM(preco)
        from venda as v, lote as l
        where l.id_lote = v.id_lote and id_cliente = id_cliente
        group by id_cliente;

--Valor total comprado pelo estado de MG--
create view compra_uf as
select uf, SUM(preco)
        from venda as v, lote as l, cliente as c
        where l.id_lote = v.id_lote and v.id_cliente = c.id_cliente and uf = 'MG'
        group by uf;

--Calcular a média de litros de leite produzidos na fazenda--
create view media_leite_total as
select avg(litros)
        from leite;

--Associar o nome de cada remédio aplicado ao nome do respectivo animal--
create table vaca_remedio as
        select a.id_animal, nome_animal, nome_remedio
        from aplicacao_remedio as ar, remedio as r, animal as a
        where r.id_remedio = ar.id_remedio and ar.id_animal = a.id_animal    
        group by a.id_animal, nome_animal, nome_remedio order by id_animal;
create view animal_com_remedio as
select vr.nome_remedio, a.nome_animal
        from vaca_remedio as vr
        left join animal as a
        on a.id_animal = vr.id_animal;

--Retornar o nome do animal que não possui aplicação de remédio e o campo remédio nulo--
create view animal_sem_remedio as
select vr.nome_remedio, a.nome_animal
        from vaca_remedio as vr
        right join animal as a
        on a.id_animal = vr.id_animal where nome_remedio is null;



