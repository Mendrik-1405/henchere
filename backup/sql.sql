
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

create TABLE mise(
    id serial primary key,
    enchereid int,
    loginid int,
    prix double precision NOT NULL default 0,
    datemise timestamp,
    foreign key (enchereid) references enchere(id),
    foreign key (loginid) references login(id)
);

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

INSERT INTO login (nom, prenom, contact, email, pwd, etat) VALUES 
('Dupont','Jean','0612345678','jean.dupont@gmail.com','motdepasse',0),
('Martin','Marie','0623456789','marie.martin@gmail.com','motdepasse',0),
('Petit','Luc','0634567890','luc.petit@gmail.com','motdepasse',0),
('Durand','Emilie','0645678901','emilie.durand@gmail.com','motdepasse',0),
('Leroy','Julie','0612345678','julie.leroy@gmail.com','motdepasse',0),
('Moreau','Sophie','0623456789','sophie.moreau@gmail.com','motdepasse',0),
('Simon','Benjamin','0634567890','benjamin.simon@gmail.com','motdepasse',0),
('Laurent','Catherine','0645678901','catherine.laurent@gmail.com','motdepasse',0),
('Lefebvre','Nicolas','0612345678','nicolas.lefebvre@gmail.com','motdepasse',0),
('Michel','Julien','0623456789','julien.michel@gmail.com','motdepasse',0),
('Garcia','Sandra','0634567890','sandra.garcia@gmail.com','motdepasse',0),
('David','Loic','0645678901','loic.david@gmail.com','motdepasse',0),
('Bertrand','Emmanuel','0612345678','emmanuel.bertrand@gmail.com','motdepasse',0),
('Dumont','Sebastien','0623456789','sebastien.dumont@gmail.com','motdepasse',0),
('Lambert','Damien','0634567890','damien.lambert@gmail.com','motdepasse',0),
('Fontaine','Cyril','admin1@example.com','cyril.fontaine@gmail.com','motdepasse',50),
('Rousseau','Denis','admin2@example.com','denis.rousseau@gmail.com','motdepasse',50),
('Vincent','Cedric','admin3@example.com','cedric.vincent@gmail.com','motdepasse',50);

INSERT INTO recharge (loginid, etat, montant) VALUES 
(1,0,1000),
(1,0,500),
(1,50,200),
(2,0,800),
(2,0,300),
(2,50,100),
(3,0,1200),
(3,0,600),
(3,50,400),
(4,0,1400),
(4,0,700),
(4,50,500),
(5,0,1600),
(5,0,800),
(5,50,600),
(6,0,1800),
(6,0,900),
(6,50,700),
(7,0,2000),
(7,0,1000),
(7,50,800),
(8,0,2200),
(8,0,1100),
(8,50,900),
(9,0,2400),
(9,0,1200),
(9,50,1000),
(10,0,2600),
(10,0,1300),
(10,50,1100),
(11,0,2800),
(11,0,1400),
(11,50,1200),
(12,0,3000),
(12,0,1500),
(12,50,1300),
(13,0,3200),
(13,0,1600),
(13,50,1400),
(14,0,3400),
(14,0,1700),
(14,50,1500),
(15,0,3600),
(15,0,1800),
(15,50,1600);
