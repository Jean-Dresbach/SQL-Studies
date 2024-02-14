create table users (
	id uuid default uuid_generate_v4() primary key,	
	"name" varchar(100) not null,
	email varchar(100) unique not null,
	"password" varchar(100) not null
);

create type transaction_type
as enum ('Income', 'Expenses');

create table categories (
	id uuid default uuid_generate_v4() primary key,	
	"name" varchar(100) not null,
	"type" transaction_type not null,
	user_id uuid not null,
	
	foreign key (user_id) references users(id)
	on delete cascade 
	on update cascade
);

create table bank_accounts (
	id uuid default uuid_generate_v4() primary key,	
	"name" varchar(100) not null,
	initial_balance decimal(10,2) default 0,
	user_id uuid not null,
	
	foreign key (user_id) references users(id) 
	on delete cascade 
	on update cascade
);

create table transactions (
	id uuid default uuid_generate_v4() primary key,
	description varchar(100) not null,
	value decimal(10,2) not null,
	transaction_date date not null,
	user_id uuid not null,
	category_id uuid not null,
	bank_account_id uuid not null,
	
	foreign key (user_id) references users(id)
	on delete cascade 
	on update cascade,
	foreign key (category_id) references categories(id)
	on delete cascade 
	on update cascade,
	foreign key (bank_account_id) references bank_accounts(id)
	on delete cascade 
	on update cascade
);

insert into users 
	("name", email, "password") 
values
	('Jean Dresbach', 'teste-1@gmail.com', 'teste1abc'),
	('Carla Silva', 'teste-2@gmail.com', 'teste2abc'),
	('Augusto Rost', 'teste-3@gmail.com', 'teste3abc');
	
insert into categories 
	("name", "type", user_id) 
values
	('Salario', 'Income', '2ae8b520-18cd-49b7-a632-76c79dfeb639'),
	('Contas', 'Expenses', '2ae8b520-18cd-49b7-a632-76c79dfeb639'),
	('Salario', 'Income', '94f4a0e6-491d-41ea-89f3-6747851f1cc7'),
	('Contas', 'Expenses', '94f4a0e6-491d-41ea-89f3-6747851f1cc7'),
	('Salario', 'Income', 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be'),
	('Contas', 'Expenses', 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be');
	
insert into bank_accounts 
	("name", user_id)
values
	('Nubank', '2ae8b520-18cd-49b7-a632-76c79dfeb639');

insert into bank_accounts 
	("name", initial_balance, user_id)
values
	('Nubank', 5206.56, '94f4a0e6-491d-41ea-89f3-6747851f1cc7'),
	('Nubank', 2165.21, 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be');

insert into transactions
	(description, value, transaction_date, user_id, category_id, bank_account_id)
values
	('Pagamento salario', 2000.50, '2024-03-20', '2ae8b520-18cd-49b7-a632-76c79dfeb639', '6af51afc-c583-49b1-959f-deb5ad27c948', 'baf4a6ae-2241-4ab5-9f05-5e2bc771eb03'),
	('Despesas com comida', 1000, '2024-03-22', '2ae8b520-18cd-49b7-a632-76c79dfeb639', 'ee0767a7-1cab-43d1-a250-cfe77ac97d6d', 'baf4a6ae-2241-4ab5-9f05-5e2bc771eb03'),
	('Boletos', 850.50, '2024-03-25', '2ae8b520-18cd-49b7-a632-76c79dfeb639', 'ee0767a7-1cab-43d1-a250-cfe77ac97d6d', 'baf4a6ae-2241-4ab5-9f05-5e2bc771eb03'),
	('Pagamento salario', 3500.59, '2024-01-15', '94f4a0e6-491d-41ea-89f3-6747851f1cc7', 'fcbef5ab-301d-48fd-8e43-b57856f75d59', '70219b13-2d42-4640-afff-412b92906148'),
	('Despesas com comida', 1500, '2024-01-27', '94f4a0e6-491d-41ea-89f3-6747851f1cc7', '63e4f478-95a7-449f-807c-15641d791219', '70219b13-2d42-4640-afff-412b92906148'),
	('Despesas com viagens', 2000, '2024-01-28', '94f4a0e6-491d-41ea-89f3-6747851f1cc7', '63e4f478-95a7-449f-807c-15641d791219', '70219b13-2d42-4640-afff-412b92906148'),
	('Pagamento salario', 2000.50, '2024-03-10', 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be', '0611abf4-1477-498d-85ca-fa05ce5ed654', '2fbcb3f5-2dd8-42f1-b406-3892f3068780'),
	('Despesas com comida', 1200, '2024-03-15', 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be', '3607bdbe-2a44-47de-b4e5-6f5cccadb984', '2fbcb3f5-2dd8-42f1-b406-3892f3068780'),
	('Boletos', 300, '2024-03-20', 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be', '3607bdbe-2a44-47de-b4e5-6f5cccadb984', '2fbcb3f5-2dd8-42f1-b406-3892f3068780');


-- Listar todas as transações de um usuário específico

select u."name" as user_name, t.description as transaction_description, t.value as transaction_value
	from transactions t 
join users u
	on t.user_id = u.id
where u.id = 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be';


-- Listar todas as transações de despesas (EXPENSE) de um usuário

select u."name" as user_name, c."type" as transaction_type, t.description as transaction_description, t.value as transaction_value
	from users u
join transactions t
	on u.id = t.user_id
join categories c
	on t.category_id = c.id
where c."type" = 'Expenses'
	and u.id = 'acfcf1bc-d1b9-4fe4-866c-ceff5c3f83be';

