-- Criar uma função que mostre a quantidade de vacinas que um animal tomou
create function quantidade()
returns void as $$
declare 
	c cursor is select *from animal;
	aux1 vacinacao%ROWTYPE;
	curs animal%ROWTYPE;
	contador int := 0;
begin
	open c;
	loop
	contador := 0;
		FETCH c INTO curs;
		EXIT WHEN NOT FOUND;
		for aux1 in select *from vacinacao loop
			if curs.id_animal = aux1.id_animal then
				contador := contador + 1;
			end if;
		end loop;
		raise notice 'A animal % cujo id e % tomou % vacinas', curs.nome_animal, curs.id_animal, contador;
		--curs.quantidade_vacina := contador;
	end loop;
	--RETURN QUERY SELECT * FROM animal;
end;
$$ language plpgsql;

--Retornar o nome do animal correspondente conforme o número de ID selecionado--
create function animal_id_nome(id int) returns text as $$
declare
    nome text;
begin
    case id
    when 1 then nome = 'Lola';
    when 2 then nome = 'Goiaba';
    when 3 then nome = 'Esmeralda';
    when 4 then nome = 'Paixão';
    when 5 then nome = 'Serenata';
    when 6 then nome = 'Lulu';
    when 7 then nome = 'Xena';
    when 8 then nome = 'Cegonha';
    when 9 then nome = 'Bilú';
    else nome = 'desconhecido';
    end case;
    return nome;
end;
$$ language plpgsql;


--Recebe o id do remédio e retornar os nomes dos animais medicados com ele-- 
create function remedio_animal(id_rem int) returns
    SETOF animal.nome_animal%TYPE as $$
declare
    nome animal.nome_animal%TYPE;
begin
    return query select nome_animal
    from animal as a, aplicacao_remedio as ar
    where a.id_animal = ar.id_animal and ar.id_remedio = id_rem;
    return;
end;
$$ language plpgsql;


-- Recebe uma data e retorna as datas de aplicações de remédio porteriores a data recebida --
create function remedio_data(rem_data date) returns
    SETOF aplicacao_remedio.data%TYPE as $$
declare
    x aplicacao_remedio.data%TYPE;
begin
    return query select data
    from animal as a, aplicacao_remedio as ar
    where a.id_animal = ar.id_animal and ar.data >= rem_data;
    return;
end;
$$ language plpgsql;


--Recebe id do animal e informa o total de leite produzido por ele--
create function leite_total(id_anim int) returns
    SETOF leite.litros%TYPE as $$
begin
    return next SUM(litros) as litros
    from leite as l
    where l.id_animal = id_anim;
    return;
end
$$ language plpgsql;


--Recebe id do lote e informa o total de leite produzido por ele--
create function total_lote(id_lot int) returns
    SETOF leite.litros%TYPE as $$
begin
    return next SUM(litros) as litros
    from leite as l
    where l.id_lote = id_lot;
    return;
end
$$ language plpgsql;














create function remedio_data(rem_data date) returns setof
    record as $$
declare
    x record;
begin
    for x in select data, ar.id_animal, nome_animal 
    from animal as a, aplicacao_remedio as ar
    where a.id_animal = ar.id_animal and ar.data >= rem_data
loop    
    return next x;
end loop;    
return;
end;
$$ language plpgsql;





create function remedio_data(rem_data aplicacao_remedio.data%TYPE) returns date as $$
declare
    linha aplicacao_remedio%rowtype;
begin
    select * into linha 
    from aplicacao_remedio where data >= rem_data;
    return linha.data || ' ' || linha.id_animal;
end;
$$ language plpgsql;




CREATE OR REPLACE FUNCTION prof_nome_completo(id professor.id_professor%TYPE) RETURNS VARCHAR AS $$
DECLARE
linha professor%ROWTYPE;
BEGIN
SELECT * INTO linha FROM professor WHERE id_professor = id;
RETURN linha.nome_professor || ' ' || linha.sobrenome;
END;
$$ LANGUAGE plpgsql;
SELECT prof_nome_completo(10);


















