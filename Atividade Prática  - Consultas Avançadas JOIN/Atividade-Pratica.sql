-- 1 - Todos os clientes do estado de MG que tenham comprado o produto que contenha em seu nome “Sapatilha em Couro Vazada”

select 
	c."name" as customer_name, 
	ca.state, 
	i."name" as item_name 
from 
	customer c
join 
	customer_address ca on c.id = ca.customer_id
join 
	orders o on c.id = o.customer_id 
join 
	items i on o.id = i.id
where 
	ca.state = 'MG'
	and i."name" ilike 'Sapatilha em Couro Vazada%';

	
-- 2 - Todos os nomes e telefones dos clientes do estado de SP que efetuaram compras cuja faixa de valor esteja acima de R$8.000
	
select 
	c."name" as customer_name, 
	c.phone, 
	ca.state, 
	o.total 
from 
	customer c
join 
	customer_address ca on c.id = ca.customer_id
join 
	orders o on c.id = o.customer_id 
where 
	ca.state = 'SP'
	and o.total > 8000;
	

-- 3 - O nome do cliente que teve o maior desconto em sua compra e o valor do desconto obtido

select 
	c."name" as customer_name, 
	max(o.discount) as biggest_discount
from 
	customer c
join 
	orders o on c.id = o.customer_id
group by 
	c."name"
order by 
	biggest_discount desc 
limit 1;