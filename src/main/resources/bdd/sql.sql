create table tokenexp (
    duree time not null
);
INSERT INTO tokenexp(duree) VALUES('00:05:00');
    
CREATE PROCEDURE removetoken()
LANGUAGE SQL
AS $$
    delete from token where dateins < current_timestamp - (select duree from tokenexp);
$$;