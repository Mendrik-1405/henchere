create table genre (
    id serial primary key,
    name varchar(255) not null,
    value numeric(6,2)
);

create table religion (
    id serial primary key,
    name varchar(255) not null,
    value numeric(6,2)
);

create table Couleur (
    id serial primary key,
    name varchar(255) not null,
    value numeric(6,2)
);

create table Diplome (
    id serial primary key,
    name varchar(255) not null,
    value numeric(6,2)
);

create table Personne (
    id serial primary key,
    nom varchar(50),
    prenom varchar(50),
    naissance date,
    salaire numeric(12,2),
    taille numeric(6,2),
    masse numeric(6,2),
    religionid int,
    couleurid int,
    diplomeid int,
    genreid int,
    description text,
    frequence numeric(6,2),
    noteMin numeric(6,2),
    email varchar(50),
    contact varchar(50)
);
alter table Personne add foreign key (religionid) references religion(id);
alter table Personne add foreign key (couleurid) references Couleur(id);
alter table Personne add foreign key (diplomeid) references Diplome(id);
alter table Personne add foreign key (genreid) references genre(id);

create table Critere (
    id serial primary key,
    critere  int,
    value1 varchar(50),
    value2 varchar(50),
    coeff numeric(6,2),
    idPersonne int
);
alter table Critere add foreign key(idPersonne) references personne(id);

create or replace view vPerson as
Select p.*,
    (current_date-p.naissance)/365 age
from personne p;

insert into genre(name) values('Homme');
insert into genre(name) values('Femme');

insert into Couleur(name,value) values('Blanche1',1);
insert into Couleur(name,value) values('Blanche2',2);
insert into Couleur(name,value) values('Melange1',3);
insert into Couleur(name,value) values('Melange2',4);
insert into Couleur(name,value) values('Noire1',5);
insert into Couleur(name,value) values('Noire2',6);

insert into religion(name) values('FJKM');
insert into religion(name) values('Katholique');
insert into religion(name) values('FLM');
insert into religion(name) values('Other');

insert into Diplome(name,value) values('Rien',-9);
insert into Diplome(name,value) values('CEPE',-6);
insert into Diplome(name,value) values('BEPC',-3);
insert into Diplome(name,value) values('BACC',0);
insert into Diplome(name,value) values('BACC+3',3);
insert into Diplome(name,value) values('BACC+5',6);
insert into Diplome(name,value) values('BACC+8',9);
insert into Diplome(name,value) values('BACC+13',12);
insert into Diplome(name,value) values('Plus',15);

