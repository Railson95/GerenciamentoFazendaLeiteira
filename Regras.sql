-- Criar uma regra que crie um campo total_litros na tabela animal e que o mesmo seja atualizado a cada 
-- nova atualização de animais na tabela leite
-- Regra que atualiza o total_litros a cada nova inserçõa no banco de dados
alter table animal add total_litros real;

update animal as a
set total_litros = d.total 
from (
	 	select id_animal, sum(litros) as total
	 	from leite
	 	group by id_animal
	 ) as d 
	where a.id_animal = d.id_animal;

create rule atualiza_leite_insert as
on insert to leite do also (
	update animal as a
	set total_litros = d.total
	from(
			select l.id_animal, sum(l.litros) as total
	 		from leite as l,
	 			 animal as a 
	 		where a.id_animal = l.id_animal
	 		group by l.id_animal
		) as d
	where a.id_animal = d.id_animal
		  and a.id_animal = NEW.id_animal	
);

create rule atualiza_leite_delete as
on delete to leite do also (
	update animal as a
	set total_litros = total
	from(
			select l.id_animal, sum(l.litros) as total
	 		from leite as l,
	 			 animal as a
	 		where l.id_animal = a.id_animal
	 			 -- and a.id_animal = old.id_animal
	 		group by l.id_animal
		) as d
	where a.id_animal = d.id_animal	
		 and a.id_animal = OLD.id_animal;
);

create rule atualiza_leite_update as
on update to leite do also (
	update animal as a
	set total_litros = d.total
	from(
			select l.id_animal, sum(l.litros) as total
	 		from leite as l,
 			 	 animal as a 
	 		where a.id_animal = l.id_animal
	 		group by l.id_animal
		) as d
	where a.id_animal = d.id_animal	
		 and a.id_animal in(new.id_animal, old.id_animal)
);

-- Criar uma regra que mostre a quantidade de vezes que cada animal foi vacinado, e que atualize o campo no caso de modificações na tabela vacinação
alter table animal add qtd_vacinada int;
update animal as a
set qtd_vacinada = d.quantidade
from(
		select v.id_animal, count(*) as quantidade
		from vacinacao as v,
			   animal as an 
	    where an.id_animal = v.id_animal
	    group by v.id_animal
	) as d
	where a.id_animal = d.id_animal; 

create rule quantidade_vacinado_insert as
on insert to vacinacao do also (
update animal as a
set qtd_vacinada = d.quantidade
from(
		select v.id_animal, count(*) as quantidade
		from vacinacao as v,
			   animal as an 
	    where an.id_animal = v.id_animal
	    group by v.id_animal
	) as d
	where a.id_animal = d.id_animal
		  and a.id_animal = NEW.id_animal
);

create rule quantidade_vacinado_delete as
on delete to vacinacao do also (
update animal as a
set qtd_vacinada = d.quantidade
from(
		select v.id_animal, count(*) as quantidade
		from vacinacao as v,
			   animal as an 
	    where an.id_animal = v.id_animal
	    group by v.id_animal
	) as d
	where a.id_animal = d.id_animal
		  and a.id_animal = old.id_animal
);

create rule quantidade_vacinado_update as
on update to vacinacao do also (
update animal as a
set qtd_vacinada = d.quantidade
from(
		select v.id_animal, count(*) as quantidade
		from vacinacao as v,
			   animal as an 
	    where an.id_animal = v.id_animal
	    group by v.id_animal
	) as d
	where a.id_animal = d.id_animal
		  and a.id_animal in(new.id_animal, old.id_animal)
);

-- Criar uma regra que calcule a quantidade media de litros de leite produzida por cada animal, e que atualize o campo media_leite em caso de modificações automaticamente
alter table animal add media_leite real;

update animal as a
set media_leite = d.media 
from (
	 	select l.id_animal, avg(litros) as media
	 	from leite as l,
	 		 animal as a
	 	where a.id_animal = l.id_animal
	 	group by l.id_animal
	 ) as d 
	where a.id_animal = d.id_animal;

create rule atualiza_media_leite_insert as
on insert to leite do also (
update animal as a
set media_leite = d.media 
from (
	 	select l.id_animal, avg(litros) as media
	 	from leite as l,
	 		 animal as a
	 	where a.id_animal = l.id_animal
	 	group by l.id_animal
	 ) as d 
	where a.id_animal = d.id_animal
		  and a.id_animal = NEW.id_animal	
);

create rule atualiza_media_leite_delete as
on delete to leite do also (
update animal as a
set media_leite = d.media 
from (
	 	select l.id_animal, avg(l.litros) as media
	 	from leite as l,
	 		 animal as a
	 	where a.id_animal = l.id_animal
	 	group by l.id_animal
	 ) as d 
	where a.id_animal = d.id_animal
		  and a.id_animal = old.id_animal	
);

create rule atualiza_media_leite_update as
on update to leite do also (
update animal as a
set media_leite = d.media 
from (
	 	select l.id_animal, avg(l.litros) as media
	 	from leite as l,
	 		 animal as a
	 	where a.id_animal = l.id_animal
	 	group by l.id_animal
	 ) as d 
	where a.id_animal = d.id_animal
		  and a.id_animal IN (NEW.id_animal, OLD.id_animal);	
);


-- Criar um regra que mostre quantas vezes um remédio foi aplicado, e se o mesmo for usado novamente, modificado ou deletado essa quantidade
-- deve ser atualizada automáticamente e o campo quantidade_aplicada na tabela remédio deve ser atualizado

alter table remedio add quantidade_aplicada real;

update remedio as a
set quantidade_aplicada = d.quantidade
from (
	 	select r.id_remedio, count(*) as quantidade
	 	from remedio as r,
	 		 aplicacao_remedio as ar
	 	where r.id_remedio = ar.id_remedio
	 	group by r.id_remedio
	 ) as d 
	where a.id_remedio = d.id_remedio;

create rule atualiza_qtd_remedio_aplicado_insert as
on insert to aplicacao_remedio do also (
update remedio as a
set quantidade_aplicada = d.quantidade
from (
	 	select r.id_remedio, count(*) as quantidade
	 	from remedio as r,
	 		 aplicacao_remedio as ar
	 	where r.id_remedio = ar.id_remedio
	 	group by r.id_remedio
	 ) as d 
	where a.id_remedio = d.id_remedio
--		  and a.id_remedio = NEW.id_remedio	
);

create rule atualiza_qtd_remedio_aplicado_delete as
on delete to aplicacao_remedio do also (
update remedio as a
set quantidade_aplicada = d.quantidade
from (
	 	select r.id_remedio, count(*) as quantidade
	 	from remedio as r,
	 		 aplicacao_remedio as ar
	 	where r.id_remedio = ar.id_remedio
	 	group by r.id_remedio
	 ) as d 
	where a.id_remedio = d.id_remedio
		  and a.id_remedio = old.id_remedio	
);

create rule atualiza_qtd_remedio_aplicado_delete as
on update to aplicacao_remedio do also (
update remedio as a
set quantidade_aplicada = d.quantidade
from (
	 	select r.id_remedio, count(*) as quantidade
	 	from remedio as r,
	 		 aplicacao_remedio as ar
	 	where r.id_remedio = ar.id_remedio
	 	group by r.id_remedio
	 ) as d 
	where a.id_remedio = d.id_remedio
		  and a.id_remedio IN (NEW.id_remedio, OLD.id_remedio);
);


