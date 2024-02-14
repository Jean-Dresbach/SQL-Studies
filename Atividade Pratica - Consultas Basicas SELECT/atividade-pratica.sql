-- 1 - Todos os clientes do estado de MG

select customer."name" as name_client
from customer
  join customer_address on customer.id = customer_address.customer_id
where customer_address.state = 'MG';

-- 2 - Todos os clientes do sexo masculino que moram na cidade de São Paulo (capital)

select customer."name" as name_client
from customer
join customer_address 
	on customer.id = customer_address.customer_id
where customer_address.city = 'São Paulo'
  and customer.gender = 'male';
  
 -- 3 - Todas as compras acima de R$3.000,00 em ordem crescente;
 
select c."name", o.total  
from orders o
join customer c 
	on o.customer_id = c.id 
where o.total > 3000
order by o.total asc

-- 4 - Todos os produtos que tenham em seu nome “Sapatilha em Couro Vazada”

select *
from items i
where i."name" 
	ilike 'Sapatilha em Couro Vazad%'