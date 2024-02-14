create table estado (
	id serial primary key,
	uf char(2),
	nome varchar(100)
);

create table cidade (
	id serial primary key,
	nome varchar(100),
	
	id_estado int references estado(id) 
	on delete cascade 
	on update cascade
);

create table cliente (
    id serial primary key,
    nome varchar(100),
    CPF char(11) unique,
    data_nascimento date,
    logradouro varchar(100),
    
    id_cidade int references cidade(id)
);

create table veiculo (
    id serial primary key,
    modelo varchar(100),
    ano date,
    placa char(7),
    
    id_cliente int references cliente(id)
);

create table forma_pagamento (
	id serial primary key,
	tipo_pagamento varchar(100)
);

create table vendas (
	id serial primary key,
	data date,
	valor decimal(10,2),
	
	id_forma_pagamento int references forma_pagamento(id),
	id_cliente int references cliente(id)
	on delete cascade 
	on update cascade
);

create table acompanhamento (
	id serial primary key,
	status char(1),
	
	id_vendas int references vendas(id)
	on delete cascade 
	on update cascade
);

create table produto (
	id serial primary key,
	nome varchar(100),
	valor decimal(10,2)
);

create table servicos (
	id serial primary key,
	nome varchar(100),
	valor decimal(10,2)
);

create table itens_vendas (
	id serial primary key,
	
	id_vendas int references vendas(id)
	on delete cascade 
	on update cascade,
	id_servico int references servicos(id),
	id_produto int references produto(id)
);

insert 
	into estado (uf, nome) 
values 
	('MG', 'Minas Gerais'),
	('RS', 'Rio Grande do Sul');

insert 
	into cidade (nome, id_estado)
values 
	('Divinópolis', 1),
	('Sapiranga', 2);

insert
	into cliente (nome, cpf, data_nascimento, logradouro, id_cidade)
values
	('Eduardo Faria', 11111111111, '1983-08-06', 'Rua Formosa', 1),
	('Jean Rafael Dresbach', 22222222222, '2002-11-04', 'Rua Santa Helena', 2);

insert
	into veiculo (modelo, ano, placa, id_cliente)
values
	('Volkswagen Gol', '2020-08-02', 'ABC1234', 1),
	('Chevrolet Onix', '2018-05-26', 'DEF5678', 2);

insert 
	into forma_pagamento (tipo_pagamento)
values
	('Débito'),
	('Crédito');

insert 
	into vendas ("data", valor, id_forma_pagamento, id_cliente)
values
	('2024-01-21', 900, 1, 1),
	('2023-12-25', 1100, 2, 2);

insert
	into acompanhamento (status, id_vendas)
values
	('A', 1),
	('F', 2);

insert
	into produto (nome, valor)
values
	('Produto 1', 500),
	('Produto 2', 600);

insert
	into servicos (nome, valor)
values
	('Serviço 1', 400),
	('Serviço 2', 500);
	
insert
	into itens_vendas (id_vendas, id_servico, id_produto)
values
	(1, 1, 1),
	(2, 2, 2);