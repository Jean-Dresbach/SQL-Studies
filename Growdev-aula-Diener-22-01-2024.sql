create table class (
	id uuid default uuid_generate_v4() primary key,
	"name" varchar(100) not null,
	begining_date date not null,
	end_date date not null
);

create table personal_data (
	id uuid default uuid_generate_v4() primary key,
	"name" varchar(100) not null,
	surname varchar(100) not null,
	CPF varchar(11) unique not null
)

create table student (
	id uuid default uuid_generate_v4() primary key,
	personal_data_id uuid not null,
	class_id uuid not null,
	active boolean default true,

	foreign key (personal_data_id) references personal_data(id),
	foreign key (class_id) references class(id)
)

create table teacher (
	id uuid default uuid_generate_v4() primary key,
	personal_data_id uuid not null,
	specialty varchar(100) not null,

	foreign key (personal_data_id) references personal_data(id)
)

create table lesson (
	id uuid default uuid_generate_v4() primary key,
	teacher_id uuid not null,
	class_id uuid not null,

	foreign key (teacher_id) references teacher(id),
	foreign key (class_id) references class(id)
)

insert into class ("name", begining_date, end_date) values ('16a PSFSWD', '2023-05-16', '2024-05-16')

insert into personal_data ("name", surname, CPF) values ('Jean', 'Dresbach', '70099464055'), ('Diener', 'Dornelas', '32145698756'), ('Carla', 'Silva', '45698712354')

insert into student (personal_data_id, class_id) values ('f5d90098-f227-4b13-b841-156d622676a2', 'dc81b5ea-2b54-4dec-a630-e1144ab2d070')

insert into teacher (personal_data_id, specialty) values ('d83a8bd1-ce55-47bc-a289-9c1cab28ce60', 'Back-end'), ('c95b3cbc-6a0f-4e2e-82ef-3eb2f53bdba7', 'Front-end')

insert into lesson (teacher_id, class_id) values ('0ba62e85-daa1-4b86-b311-5bdfb3a2e709', 'dc81b5ea-2b54-4dec-a630-e1144ab2d070'), ('9f8f6097-46b1-43ee-988c-216795e7a0b6', 'dc81b5ea-2b54-4dec-a630-e1144ab2d070')

select * from student
select * from class
select * from teacher

select class.* 
from class
inner join lesson on class_id = class.id
where lesson.teacher_id = '0ba62e85-daa1-4b86-b311-5bdfb3a2e709'

select class.*, personal_data."name"
from class
inner join lesson on class_id = class.id
inner join teacher on lesson.teacher_id = teacher.id
inner join personal_data on teacher.personal_data_id = personal_data.id
-- where lesson.teacher_id = '0ba62e85-daa1-4b86-b311-5bdfb3a2e709'

select * from teacher t
join personal_data pd on t.personal_data_id  = pd.id

select * from student s
join "class" c on c.id = s.class_id
where c.id = 'dc81b5ea-2b54-4dec-a630-e1144ab2d070'

select c."name" from "class" c
join student s on c.id = s.class_id
where s.id = '164e1885-0e53-445c-820b-5524625bba5c'