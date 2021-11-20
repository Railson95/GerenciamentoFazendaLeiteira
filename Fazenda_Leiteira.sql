
create table remedio(
	id_remedio serial not null,
	nome_remedio varchar(50),
	tratamento varchar(50),
	constraint id_remedio_pk primary key(id_remedio)
);

insert into remedio(nome_remedio, tratamento) values
('Ripercol', 'Verminoses'),
('Ivomec Injetável', 'Parasitas'),
('Ciprolac','Mastite'),
('Organnact Prata', 'Bicheiras');


create table veterinario(
	crmv_veterinario real not null,
	nome_veterinario varchar(100),
	constraint crmv_veterinario_pk primary key(crmv_veterinario)
);

insert into veterinario(crmv_veterinario, nome_veterinario) values
(204, 'TÂNIA LINO FIUZA'),
(9905, 'EDUARDO NUNES AMARANTE'),
(49707, 'VALDIVINO AMERICO VIEIRA');

create table vacina(
	id_vacina serial not null,
	nome_vacina varchar(50),
	tratamento varchar(50),
	constraint id_vacina_pk primary key (id_vacina)
);

INSERT INTO vacina(nome_vacina, tratamento)
VALUES
('Baymec Injetável','Parasitas'),
('Anabortina', 'Febre Mediterrânea'),
('Raiva Vencofarma','Raiva');

Create table animal(
	id_animal BIGSERIAL not null,
	nome_animal VARCHAR(30),
	sexo CHAR(2),
	constraint animal_pk primary key (id_animal)
);

INSERT INTO animal(nome_animal, sexo)
VALUES
('Lola', 'F'),
('Goiaba', 'F'),
('Esmeralda', 'F'),
('Paixão', 'F'),
('Serenata', 'F'),
('Lulu', 'F'),
('Xena', 'F'),
('Cegonha', 'F'),
('Bilú', 'M');

create table aplicacao_remedio(
	id_remedio serial not null,
	crmv_veterinario real not null,
	id_animal bigserial not null,
	data date,
	constraint id_remedio_fk foreign key(id_remedio) references remedio(id_remedio),
	constraint crmv_veterinario_fk foreign key(crmv_veterinario) references veterinario(crmv_veterinario),
	constraint id_animal_fk foreign key(id_animal) references animal(id_animal)
);

insert into aplicacao_remedio(id_remedio, crmv_veterinario, id_animal, data) values
(1,204,1,'2017-12-16'),
(3,49707,9,'2017-12-22'),
(2,9905,3,'2017-12-28'),
(2,204,4,'2018-1-5'),
(1,204,8,'2018-1-6'),
(4,9905,6,'2018-2-3'),
(3,204,7,'2018-2-17'),
(2,204,8,'2018-2-28'),
(1,49707,9,'2018-3-10'),
(4,9905,1,'2018-4-1'),
(3,204,2,'2018-1-13'),
(4,9905,3,'2018-4-5'),
(4,204,4,'2018-5-29'),
(1,9905,6,'2018-5-30'),
(2,49707,9,'2018-6-3');

create table vacinacao(
	id_vacina serial not null,
	crmv_veterinario real not null,
	id_animal bigserial not null,
	data date,
	constraint id_vacina_fk foreign key(id_vacina) references vacina(id_vacina),
	constraint crmv_veterinario_fk foreign key(crmv_veterinario) references veterinario(crmv_veterinario),
	constraint id_animal_fk foreign key(id_animal) references animal(id_animal)
);

INSERT INTO vacinacao(id_vacina, crmv_veterinario, id_animal, data)
VALUES
(1, 204, 1, '2018-01-22'),
(1, 204, 2, '2018-01-22'),
(1, 204, 3, '2018-01-22'),
(1, 204, 4, '2018-01-22'),
(1, 204, 5, '2018-01-22'),
(1, 204, 6, '2018-01-22'),
(1, 204, 7, '2018-01-22'),
(1, 204, 8, '2018-01-22'),
(1, 204, 9, '2018-01-22'),
(2, 9905, 1, '2017-12-10'),
(2, 9905, 2, '2017-12-10'),
(2, 9905, 3, '2017-12-10'),
(2, 9905, 4, '2017-12-10'),
(2, 9905, 5, '2017-12-10'),
(2, 9905, 6, '2017-12-10'),
(2, 9905, 7, '2017-12-10'),
(2, 9905, 8, '2017-12-10'),
(2, 9905, 9, '2017-12-10'),
(3, 49707, 1, '2018-03-03'),
(3, 49707, 2, '2018-03-03'),
(3, 49707, 3, '2018-03-03'),
(3, 49707, 4, '2018-03-03'),
(3, 49707, 5, '2018-03-03'),
(3, 49707, 6, '2018-03-03'),
(3, 49707, 7, '2018-03-03'),
(3, 49707, 8, '2018-03-03'),
(3, 49707, 9, '2018-03-03');

Create table lote(
	id_lote BIGSERIAL not null,
	quantidade INT not null,
	preco REAL,
	data DATE,
	constraint lote_pk primary key (id_lote)
);

ALTER SEQUENCE lote_id_lote_seq RESTART WITH 101;
INSERT INTO lote(quantidade, preco, data)
VALUES(191, 206.28, '2018-06-01'),
(203, 219.24, '2018-06-02'),
(208, 224.64, '2018-06-03'),
(205, 221.40, '2018-06-04'),
(200, 216, '2018-06-05'),
(203, 219.24, '2018-06-06'),
(209, 225.72, '2018-06-07'),
(198, 213.84, '2018-06-08'),
(200, 216, '2018-06-09'),
(200, 216, '2018-06-10');


Create table leite(
	id_lote BIGSERIAL not null,
	id_animal BIGSERIAL not null,
	litros INT,
	data DATE,
	constraint leite_pk primary key (id_lote, id_animal),
	constraint leite_fk_lote foreign key (id_lote) references lote(id_lote),
	constraint leite_fk_animal foreign key (id_animal) references animal(id_animal)
);

INSERT INTO leite(id_lote, id_animal, litros, data)
VALUES
(101, 1, 20, '2018-06-01'),
(102, 1, 24, '2018-06-02'),
(103, 1, 27, '2018-06-03'),
(104, 1, 26, '2018-06-04'),
(105, 1, 25, '2018-06-05'),
(106, 1, 25, '2018-06-06'),
(107, 1, 24, '2018-06-07'),

(101, 2, 28, '2018-06-01'),
(102, 2, 29, '2018-06-02'),
(103, 2, 27, '2018-06-03'),
(104, 2, 29, '2018-06-04'),
(105, 2, 25, '2018-06-05'),
(106, 2, 29, '2018-06-06'),
(107, 2, 28, '2018-06-07'),

(101, 3, 22, '2018-06-01'),
(102, 3, 23, '2018-06-02'),
(103, 3, 22, '2018-06-03'),
(104, 3, 21, '2018-06-04'),
(105, 3, 24, '2018-06-05'),
(106, 3, 22, '2018-06-06'),
(107, 3, 23, '2018-06-07'),

(101, 4, 25, '2018-06-01'),
(102, 4, 28, '2018-06-02'),
(103, 4, 24, '2018-06-03'),
(104, 4, 22, '2018-06-04'),
(105, 4, 26, '2018-06-05'),
(106, 4, 21, '2018-06-06'),
(107, 4, 28, '2018-06-07'),

(101, 5, 20, '2018-06-01'),
(102, 5, 21, '2018-06-02'),
(103, 5, 25, '2018-06-03'),
(104, 5, 26, '2018-06-04'),
(105, 5, 28, '2018-06-05'),
(106, 5, 27, '2018-06-06'),
(107, 5, 24, '2018-06-07'),

(101, 6, 23, '2018-06-01'),
(102, 6, 27, '2018-06-02'),
(103, 6, 26, '2018-06-03'),
(104, 6, 28, '2018-06-04'),
(105, 6, 24, '2018-06-05'),
(106, 6, 26, '2018-06-06'),
(107, 6, 28, '2018-06-07'),

(101, 7, 29, '2018-06-01'),
(102, 7, 28, '2018-06-02'),
(103, 7, 29, '2018-06-03'),
(104, 7, 26, '2018-06-04'),
(105, 7, 27, '2018-06-05'),
(106, 7, 28, '2018-06-06'),
(107, 7, 25, '2018-06-07');


Create table cliente(
	id_cliente BIGSERIAL not null,
	cnpj CHAR(14),
	nome_cliente VARCHAR (50),
	cidade VARCHAR (30),
	uf char(2),
	constraint id_cliente_pk primary key(id_cliente)
);

INSERT INTO cliente(cnpj, nome_cliente, cidade, uf)
VALUES
('42942235000142', 'Cemil', 'Patos de Minas', 'MG'),
('18426718001424', 'Cotochés', 'Abre Campo', 'MG'),
('62545926000110', 'Camponesa', 'São Paulo', 'SP');

Create table venda(
	id_lote BIGSERIAL not null,
	id_cliente BIGSERIAL not null,
	venda int not null,
	constraint venda_pk primary key (id_lote, id_cliente),
	constraint venda_fk_lote foreign key (id_lote) references lote(id_lote),
	constraint venda_fk_cliente foreign key (id_cliente) references cliente(id_cliente)
);

INSERT INTO venda(id_lote, id_cliente, venda)
VALUES
(101, 1, 1001),
(102, 2, 1002),
(103, 1, 1001),
(104, 3, 1003),
(105, 2, 1002),
(106, 1, 1004),
(107, 2, 1005),
(108, 3, 1006),
(109, 3, 1006),
(110, 2, 1005);