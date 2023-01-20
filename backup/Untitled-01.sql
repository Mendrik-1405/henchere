-- create role manager login password 'root';
-- create database enchere;
-- alter database enchere owner to manager;

-- \c enchere manager
-- root

-- ;

CREATE TABLE admins(
    email varchar(40),  
    pwd  varchar(40)
);
CREATE TABLE login (
    id serial primary key,
    nom varchar(40),
    prenom varchar(40),
    contact varchar(40),
    email varchar(40),
    pwd  varchar(40)
);
alter table login add column etat integer not null default 0; -- 0 Client, 50 admin

create table recharge(
    id serial primary key,
    loginid int,
    montant double precision NOT NULL default 0,
    etat int,--0:entree 50:sortie 
    foreign key (loginid) references login(id)
);

create table rnotaccept(
    id serial primary key,
    loginid int,
    montant double precision,
    etat int,--0:entree 50:sortie 
    foreign key (loginid) references login(id)
);

CREATE TABLE token (
    id serial primary key,
    dateins timestamp without time zone,
    value varchar(150),
    loginid int,
    foreign key (loginid) references login(id)
);

CREATE TABLE tokenexp (
    duree time without time zone NOT NULL
);

CREATE TABLE categorie (
    id serial primary key,
    designation varchar(40)
);


create table photo(
    id serial primary key,
    designation varchar(100)
);

CREATE TABLE produit(
    id serial primary key,
    designation varchar(40),
    loginid int,
    categorieid int,
    Photoid int,--tokony not null 
    descri text,
    prixmin double precision NOT null DEFAULT 0,
    prixmax double precision NOT null DEFAULT 0,
    foreign key (categorieid) references categorie(id),
    foreign key (loginid) references login(id)
);

create table photoProduit(
    produitid int,
    photoid int,
 PRIMARY KEY (Produitid,Photoid)
);

CREATE TABLE enchere(
    id serial primary key,
    designation varchar(40),
    loginid int,
    produitid int,
    datedebut timestamp default now(),
    datefin timestamp,
    prixminmise double precision NOT null DEFAULT 10,
    etat int,--0 en cours 1 termine
    foreign key (produitid) references produit(id),
    foreign key (loginid) references login(id)
);
alter table enchere add column prixmin double precision not null default 0;

create TABLE mise(
    id serial primary key,
    enchereid int,
    loginid int,
    prix double precision NOT NULL default 0,
    datemise timestamp,
    foreign key (enchereid) references enchere(id),
    foreign key (loginid) references login(id)
);

create TABLE transactions(
    id serial primary key,
    enchereid int,
    rechargesendid int,
    rechargereceiveid int,
    montant double precision,
    datetransfer timestamp not null default now(),
    foreign key (rechargesendid) references recharge(id),
    foreign key (rechargereceiveid) references recharge(id),
    foreign key (enchereid) references enchere(id)
);
alter table transactions add column commission double precision NOT null default 0;


create table commission(
    pourcentage double precision not null
);

create table  comptesite(
    id serial primary key,
    transactionsid int,
    montant double precision,
    pourcentage int NOT null DEFAULT 20, 
    foreign key (transactionsid) references transactions(id)
);
alter table comptesite add column enchereid int;
alter table comptesite add foreign key(enchereid) references enchere(id);

create or replace procedure clotenchere(idE INTEGER) as 
$$
    Declare
        seqrechargesend int;
        seqrechargereceive int;
        seqtransactions int;
        pourcent double precision;
        syspart double precision;
        miseSender mise%ROWTYPE;
        idReceipt integer;
        idSender integer;
    BEGIN
        select nextval('recharge_id_seq') into seqrechargereceive;
        select nextval('recharge_id_seq') into seqrechargesend;
        select nextval('transactions_id_seq') into seqtransactions;
        select pourcentage from commission into pourcent;
        select * into miseSender from mise where enchereid = idE;
        select loginid into idReceipt from enchere where id = idE;
        select miseSender.prix*pourcent/100 into syspart;
        idSender := miseSender.loginid;
        IF idSender != 0 then 
            insert into recharge(id,loginid,montant,etat)values(seqrechargereceive,idReceipt,miseSender.prix-syspart,'0');
            insert into recharge(id,loginid,montant,etat)values(seqrechargesend,idSender,miseSender.prix,'50');
            insert into transactions(id,enchereid,rechargesendid,rechargereceiveid,montant,datetransfer,commission) values (seqtransactions,idE,seqrechargesend,seqrechargereceive,miseSender.prix,now(),pourcent);
            insert into comptesite(transactionsid,montant,pourcentage,enchereid)values(seqtransactions,syspart,pourcent,idE);
            update produit set loginid = idSender where id = (select produitid from enchere where id = idE);
        end if;
        update enchere set etat = 50 where id = idE;
        delete from mise where enchereid = idE;
    END;
$$ language plpgsql;

CREATE EVENT cloture_enchere_event
    ON SCHEDULE AT current_timestamp + INTERVAL '1 second'
    DO
    BEGIN
        PERFORM clotenchere(id)
        FROM enchere
        WHERE datefin <= NOW()
        and etat = 0;
    END;


CREATE OR REPLACE PROCEDURE acceptrecharge(idR INTEGER)
as $$
Declare
    rechargerow rnotaccept%ROWTYPE;
BEGIN
    select * into rechargerow from rnotaccept where id = idR;
    insert into recharge(loginid,montant,etat) values(rechargerow.loginid,rechargerow.montant, 0);
    delete from rnotaccept where id = idR;
END;
$$ LANGUAGE plpgsql;


--view recharge
create or replace view entree as(
select * from recharge where etat=0
);
create or replace view sortie as(
select * from recharge where etat=50
);

--view miasa am montant view solde login
create or replace view v_entree as(
select loginid,sum(montant)as entree from recharge where etat=0 GROUP by loginid
);
create or replace view v_sortie as(
select loginid,sum(montant)as sortie from recharge where etat=50 GROUP by loginid
);
----view montant solde login
create or replace view v_soldelogin as(
    select v_entree.loginid as id,(v_entree.entree-v_sortie.sortie) as solde from v_entree
    join v_sortie on v_entree.loginid=v_sortie.loginid
);

create or replace view v_mise as 
    select m.loginid,
        sum(m.prix) prix
    from mise m 
    group by m.loginid;

create or replace view soldelogin as 
    select s.id,
        s.solde - coalesce(m.prix,0) solde
    from v_soldelogin s left join v_mise m
    on s.id = m.loginid;

--vola n systeme
create or replace view v_soldesysteme as(
select sum(montant) as soldesys from comptesite
);

--variation vola miditra jour/mois/semaine
create or replace view v_varsoldesysjour as(
select transactions.datetransfer as jour,sum(comptesite.montant)as soldesys from comptesite
join transactions on transactions.id=comptesite.transactionsid group by jour
);
create or replace view v_varsoldesysmois as(
select extract(month from transactions.datetransfer)as mois,extract(year from transactions.datetransfer)as year,sum(comptesite.montant)as soldesys from comptesite
join transactions on transactions.id=comptesite.transactionsid group by mois,year
);
create or replace view v_varsoldesyssem as(
select extract(week from transactions.datetransfer)as semaine,sum(comptesite.montant)as soldesys from comptesite
join transactions on transactions.id=comptesite.transactionsid group by semaine
);
--variation par categorie jour/mois/semaine
create or replace view v_catvarsoldesysjour as(
select produit.categorieid as categorieid,transactions.datetransfer as jour,sum(comptesite.montant)as soldesys from comptesite
join transactions on transactions.id=comptesite.transactionsid 
join enchere on enchere.id=transactions.enchereid
join produit on produit.id=enchere.produitid
group by jour,categorieid
);
create or replace view v_catvarsoldesysmois as(
select produit.categorieid as categorieid,extract(month from transactions.datetransfer)as mois,extract(year from transactions.datetransfer)as year,sum(comptesite.montant)as soldesys from comptesite
join transactions on transactions.id=comptesite.transactionsid 
join enchere on enchere.id=transactions.enchereid
join produit on produit.id=enchere.produitid
group by mois,year,categorieid
);
create or replace view v_catvarsoldesyssem as(
select produit.categorieid as categorieid,extract(week from transactions.datetransfer)as semaine,sum(comptesite.montant)as soldesys from comptesite
join transactions on transactions.id=comptesite.transactionsid 
join enchere on enchere.id=transactions.enchereid
join produit on produit.id=enchere.produitid
group by semaine,categorieid
);
--view v_transaction
select enchere.produitid as produitid,enchere.montant as montant from enchere 
join produit 
on produit.id=enchere.produitid

CREATE OR REPLACE FUNCTION tokenexpIns()
RETURNS TRIGGER AS $$
BEGIN
  delete from tokenexp;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tokenexpIns
BEFORE INSERT ON tokenexp
FOR EACH ROW EXECUTE FUNCTION tokenexpIns();

CREATE PROCEDURE removetoken()
LANGUAGE SQL
AS $$
    delete from token where dateins < current_timestamp - (select duree from tokenexp);
$$;

CREATE OR REPLACE FUNCTION delmise()
RETURNS TRIGGER AS $$
Declare
    lastrows mise%ROWTYPE;
    prixmin double precision;
BEGIN
    IF (select etat from enchere where id = new.enchereid) = 50 then
        RAISE EXCEPTION '10#Enchere deja cloture';
    END IF;
    select * into lastrows from mise where enchereid=New.enchereid;
    select prixminmise into prixmin from enchere where id=new.enchereid;
    IF lastrows.loginid = new.loginid then
        RAISE EXCEPTION '20#La derniere personne qui a surencherit n''a pas le droit de surencherir';
    END IF;
    IF (lastrows.prix+prixmin) > new.prix or lastrows.loginid = 0 then
        RAISE EXCEPTION '30#La mise doit etre supperieur à la derniere mise qui s''eleve à % avec mise minimum de %',lastrows.prix,(lastrows.prix+prixmin);
    END if;
    delete from mise where mise.enchereid=NEW.enchereid;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER delmise
BEFORE INSERT ON mise
FOR EACH ROW EXECUTE FUNCTION delmise();

create or REPLACE FUNCTION addFirstMise() 
RETURNS TRIGGER as $$
BEGIN
    insert into mise(enchereid,loginid,prix,datemise)values(new.id,0,0,current_timestamp);
    RETURN new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER addFirstMise
AFTER INSERT ON enchere
FOR EACH ROW EXECUTE FUNCTION addFirstMise();

insert into login(id,nom,prenom,contact,email,pwd) values(0,'System','System','','','');

insert into login(nom,prenom,contact,email,pwd) values('Rakoto','Manana','0341111111','qwerty@gmail.com','1234'),('Rakoto','Malala','0342222222','azerty@gmail.com','1234');

insert into recharge(loginid,montant,etat)values('1','29000000','0'),('2','1000000','0');

insert into categorie(designation)values ('meuble'),('voiture');

insert into commission(pourcentage)values('20');

insert into produit(designation,loginid,categorieid,descri,prixmin,prixmax)values('table basse','1','1','fait en bois de rose','500000','800000'),('i30','2','2','kit sport,full option','20000000','28000000');

insert into enchere(designation,loginid,produitid,datedebut,datefin,prixminmise,etat)values('enchere','1','1','2023-01-01 08:00:00','2023-01-01 12:00:00','100000','0'),('enchere','2','2','2023-01-01 08:00:00','2023-01-01 12:00:00','28000000','0');

insert into mise(enchereid,loginid,prix,datemise)values('1','2','28000000','2023-01-01 11:30:00'),('2','2','800000','2023-01-01 11:30:00');

insert into transactions(enchereid,rechargesendid,rechargereceiveid,montant,datetransfer)values('1','1','2','22400000','2023-01-01 11:40:00'),('1','2','1','640000','2023-01-01 11:40:00');

insert into recharge(loginid,montant,etat)values('1','22400000','50'),('2','640000','50');

insert into comptesite(transactionsid,montant,pourcentage)values('1','5600000','20'),('2','160000','20');

insert into mise(enchereid,loginid,prix,datemise)values(1,1,300,'2023-01-01 11:30:00');
insert into mise(enchereid,loginid,prix,datemise)values(1,1,402,'2023-01-01 11:30:00');
insert into mise(enchereid,loginid,prix,datemise)values(2,1,801000,'2023-01-01 11:30:00');
insert into mise(enchereid,loginid,prix,datemise)values(1,2,101402,'2023-01-01 11:30:00');

create or replace view statWeek as
    select ca.id,
        SUM(c.montant) as total_ventes, 
        date_trunc('week', t.datetransfer) as semaine
    from 
        comptesite c
        left join enchere e 
        on c.enchereid = e.id
        left join produit p 
        on e.produitid = p.id
        left join categorie ca 
        on p.categorieid = ca.id
        left join transactions t
        on c.transactionsid = t.id
    GROUP BY 
        ca.id, 
        semaine
    ORDER BY 
        semaine;

create or replace view vstatWeek as
    select s.*,
        ca.designation
    from statWeek s
    left join categorie ca 
    on s.id = ca.id;


create or replace view statMonth as
    select ca.id,
        SUM(c.montant) as total_ventes, 
        date_trunc('month', t.datetransfer) as semaine
    from 
        comptesite c
        left join enchere e 
        on c.enchereid = e.id
        left join produit p 
        on e.produitid = p.id
        left join categorie ca 
        on p.categorieid = ca.id
        left join transactions t
        on c.transactionsid = t.id
    GROUP BY 
        ca.id, 
        semaine
    ORDER BY 
        semaine;


create or replace view vstatMonth as
    select s.*,
        ca.designation
    from statMonth s
    left join categorie ca 
    on s.id = ca.id;



CREATE OR REPLACE view vtauxremise as
    SELECT 
        ca.id, 
        AVG((e.prixmin - c.montant) / e.prixmin * 100) as taux_remise
    FROM 
        comptesite c
            left join enchere e 
            on c.enchereid = e.id
            left join produit p 
            on e.produitid = p.id
            left join categorie ca 
            on p.categorieid = ca.id
    GROUP BY 
        ca.id;

create or replace view tauxremise as 
    select s.*,
        ca.designation
    from vtauxremise s
    left join categorie ca 
    on s.id = ca.id;


    
CREATE TABLE login (
    id serial primary key,
    nom varchar(40),
    prenom varchar(40),
    contact varchar(40),
    email varchar(40),
    pwd  varchar(40),
    etat integer
);