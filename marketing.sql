--Datos de usuario
create table roles(
  id int auto_increment primary key,
  name text not null
);

create table users(
  id int auto_increment primary key,
  name text not null,
  last_name text not null,
  password varchar(40) not null,
  gender varchar(1) not null,
  rol int not null,
  foreign key (rol) references roles(id)
);

--Campañas
create table campaings(
  id int auto_increment primary key,
  created_by int not null,
  name text not null,
  date_start date not null,
  date_end date not null,
  status text not null,
  target text,
  description text not null,
  frecuency int,
  foreign key (created_by) references users(id)
);

create table emails(
  id int auto_increment primary key,
  created_by int not null,
  campaing_id int not null,
  date_send date,
  subject text not null,
  content text not null,
  status text,
  foreign key (created_by) references users(id),
  foreign key (campaing_id) references campaings(id)
);

--Productos
create table features(
  id int auto_increment primary key,
  feature1 text,
  feature2 text,
  features text
);

create table products(
  id int auto_increment primary key,
  created_by int not null,
  campaing_id int,
  name text not null,
  price double,
  description text,
  features int,
  foreign key (created_by) references users(id),
  foreign key (campaing_id) references campaings(id),
  foreign key (features) references features(id)
);

--Perfil del cliente
create table jobs(
  id int auto_increment primary key,
  name text not null,
  salary double
);

create table postcodes(
  id int auto_increment primary key,
  place text not null,
  city text not null,
  entity text not null
);

create table schools(
  id int auto_increment primary key,
  name text not null
);

create table types_customers(
  id int auto_increment primary key,
  name text not null
);

create table status_social(
  id int auto_increment primary key,
  name text not null
);

create table status_civil(
  id int auto_increment primary key,
  name text not null
);

create table customers(
  id int auto_increment primary key,
  name text not null,
  last_name text not null,
  birthday date,
  gender varchar(1),
  email text not null,
  telephone varchar(10),
  postcode int,
  types int,
  job int,
  school int,
  status_civil int,
  sons int,
  status_social int,
  status text,
  date_created date,
  foreign key (postcode) references postcodes(id),
  foreign key (types) references types_customers(id),
  foreign key (job) references jobs(id),
  foreign key (school) references schools(id),
  foreign key (status_civil) references status_civil(id),
  foreign key (status_social) references status_social(id)
);

--Mercados
create table teams(
  id int auto_increment primary key,
  created_by int not null,
  name text,
  description text,
  status text not null,
  date_created date,
  foreign key (created_by) references users(id)
);

create table campaing_team(
  id int auto_increment primary key,
  campaing_id int not null,
  team_id int not null,
  foreign key (campaing_id) references campaings(id),
  foreign key (team_id) references teams(id)
);

create table customer_team(
  id int auto_increment primary key,
  customer_id int not null,
  team_id int not null,
  foreign key (customer_id) references customers(id),
  foreign key (team_id) references teams(id)
);

--Roles
INSERT INTO roles (name) VALUES('Administrador');
INSERT INTO roles (name) VALUES('Jefe de Marketing');
INSERT INTO roles (name) VALUES('Promotor');
INSERT INTO roles (name) VALUES('Agente de Ventas');

--Educación
INSERT INTO schools (name) VALUES('Ninguna');
INSERT INTO schools (name) VALUES('Primaria');
INSERT INTO schools (name) VALUES('Secundaria');
INSERT INTO schools (name) VALUES('Preparatoria o Bachillerato');
INSERT INTO schools (name) VALUES('Licenciatura');
INSERT INTO schools (name) VALUES('Maestria o Doctorado');

--Estado civil
INSERT INTO status_civil (name) VALUES('Soltero');
INSERT INTO status_civil (name) VALUES('Unión Libre');
INSERT INTO status_civil (name) VALUES('Casado');
INSERT INTO status_civil (name) VALUES('Divorciado');
INSERT INTO status_civil (name) VALUES('Viudo');

--Clase social
INSERT INTO status_social (name) VALUES('Baja');
INSERT INTO status_social (name) VALUES('Media');
INSERT INTO status_social (name) VALUES('Alta');

--Ocupacion
INSERT INTO jobs (name) VALUES('Estudiante');
INSERT INTO jobs (name) VALUES('Labores del hogar');
INSERT INTO jobs (name) VALUES('Profesionales por cuenta ajena');
INSERT INTO jobs (name) VALUES('Profesionales por cuenta propia');
INSERT INTO jobs (name) VALUES('Desempleado');
INSERT INTO jobs (name) VALUES('Directivo');
INSERT INTO jobs (name) VALUES('Cargos Intermedios');
INSERT INTO jobs (name) VALUES('Otros');

