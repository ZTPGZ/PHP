create table FA_USER(
    id integer generated always as identity primary key not null,
    login varchar2(64),
    firstname varchar2(64),
    lastname varchar2(64),
    password varchar(30)
);

insert into FA_USER (login, firstname, lastname, password) values ('marius', 'Marius', 'Noack', '12345');

select id from fa_user where login = 'marius' and password='12345';
alter table FA_USER add is_frager number(1) default(0);
alter table FA_USER add constraint FA_USER_UNIQUE_LOGIN unique(login);

select * from FA_USER;

update FA_USER set is_frager = 1 where id = 1;
commit;

CREATE TABLE FA_ZEIT_ANTWORT
(	 
	id number generated always as identity primary key not null,
    num number,
    stunde number, 
    minute number,
	datum date, 
    tag varchar2(10 byte), 
	kw number(2,0), 
	jahr number(4,0), 
	tagdesmonats number(2,0), 
    tagderwoche number(1,0),
	tagimjahr number(3,0), 
	monat varchar2(10 BYTE), 
	monatnr number(2,0), 
	monatkurz varchar2(3 BYTE)
);

CREATE TABLE FA_ZEIT_FRAGE
(	 
	id number generated always as identity primary key not null,
    num number,
    stunde number, 
    minute number,
	datum date, 
    tag varchar2(10 byte), 
	kw number(2,0), 
	jahr number(4,0), 
	tagdesmonats number(2,0), 
    tagderwoche number(1,0),
	tagimjahr number(3,0), 
	monat varchar2(10 BYTE), 
	monatnr number(2,0), 
	monatkurz varchar2(3 BYTE)
);



alter table FA_ZEIT_ANTWORT add num number;
alter table FA_ZEIT_FRAGE add num number;

alter table FA_ZEIT_ANTWORT add "MINUTE" number;
alter table FA_ZEIT_FRAGE add "MINUTE" number;

create sequence SEQ_FA_ZEIT_ANTWORT start with 1 increment by 1;
create sequence SEQ_FA_ZEIT_FRAGE start with 1 increment by 1;

drop sequence SEQ_FA_ZEIT_ANTWORT;
drop sequence SEQ_FA_ZEIT_FRAGE;

select count(*) from BROCKEN_016.KK_PRODUKTE;

truncate table FA_ZEIT_FRAGE;
truncate table FA_ZEIT_ANTWORT;

drop table FA_ZEIT_FRAGE;
drop table FA_ZEIT_ANTWORT;

insert into FA_ZEIT_FRAGE ("NUM", stunde, datum, "TAG", kw, jahr, tagdesmonats, tagimjahr, monat, monatnr, monatkurz) 
    select SEQ_FA_ZEIT_FRAGE.NEXTVAL, null, null, null, null, null, null, null, null, null, null from BROCKEN_043.AF_ZEIT_ANTWORT; 

insert into FA_ZEIT_ANTWORT ("NUM", stunde, datum, "TAG", kw, jahr, tagdesmonats, tagimjahr, monat, monatnr, monatkurz) 
    select SEQ_FA_ZEIT_ANTWORT.NEXTVAL, null, null, null, null, null, null, null, null, null, null from BROCKEN_043.AF_ZEIT_ANTWORT; 
    
update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.NUM = FA_ZEIT_FRAGE.ID + ((4712 + 2020)*365.25*24*60);
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.NUM = FA_ZEIT_ANTWORT.ID + ((4712 + 2020)*365.25*24*60);
commit;

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.DATUM = to_date(floor(NUM/(24*60)), 'J');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.DATUM = to_date(floor(NUM/(24*60)), 'J');
commit;

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.DATUM = to_date(floor(NUM/(24*60)), 'J');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.DATUM = to_date(floor(NUM/(24*60)), 'J');
commit;

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.TAG = to_char(DATUM, 'Day');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.TAG = to_char(DATUM, 'Day');

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.MONAT =  to_char(DATUM, 'Month');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.MONAT =  to_char(DATUM, 'Month');

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.JAHR =  to_char(DATUM, 'YYYY');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.JAHR =  to_char(DATUM, 'YYYY');

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.TAGDERWOCHE = to_char(DATUM, 'D');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.TAGDERWOCHE = to_char(DATUM, 'D');
update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.TAGDESMONATS = to_char(DATUM, 'DD');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.TAGDESMONATS = to_char(DATUM, 'DD');
update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.TAGIMJAHR = to_char(DATUM, 'DDD');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.TAGIMJAHR = to_char(DATUM, 'DDD');
update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.KW = to_number(to_char(DATUM, 'WW'));
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.KW = to_number(to_char(DATUM, 'WW'));
update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.MONATNR = to_char(DATUM, 'MM');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.MONATNR = to_char(DATUM, 'MM');
update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.MONATKURZ = to_char(DATUM, 'MON');
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.MONATKURZ = to_char(DATUM, 'MON');

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.STUNDE = mod(floor(MOD(NUM, (4712 + 2020)*365.25*60)/ 60),24);
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.STUNDE = mod(floor(MOD(NUM, (4712 + 2020)*365.25*60)/ 60),24);
commit;

update FA_ZEIT_FRAGE set FA_ZEIT_FRAGE.minute = MOD(MOD(NUM, (4712 + 2020)*365.25), 60);
update FA_ZEIT_ANTWORT set FA_ZEIT_ANTWORT.minute =MOD(MOD(NUM, (4712 + 2020)*365.25), 60);
commit;

create table FA_FRAGEN (
    ID number generated always as identity primary key not null,
    ZEIT_FRAGE_ID number references FA_ZEIT_FRAGE(id) not null,
    USER_ID number references FA_USER(id) not null,
    TEXT varchar2(255) not null
);

create table FA_ANTWORTEN (
    ID number generated always as identity primary key not null,
    ZEIT_ANTWORT_ID number references FA_ZEIT_ANTWORT(id) not null,
    FRAGEN_ID number references FA_FRAGEN(ID) not null,
    USER_ID_ANTWORT number references FA_USER(id) not null,
    USER_ID_BEWERTUNG number references FA_USER(id) not null,
    TEXT varchar(255) not null,
    BEWERTUNG number(3,0)
);

alter table FA_ANTWORTEN modify (USER_ID_BEWERTUNG null);

insert into FA_ANTWORTEN (zeit_antwort_id, fragen_id, user_id_antwort, user_id_bewertung, text, bewertung) values (1,1,2,null,'Peter',null);
insert into FA_ANTWORTEN (zeit_antwort_id, fragen_id, user_id_antwort, user_id_bewertung, text, bewertung) values (55,2,2,1,'Aslan',40);
insert into FA_ANTWORTEN (zeit_antwort_id, fragen_id, user_id_antwort, user_id_bewertung, text, bewertung) values (1231,3,2,1,'Bobby B.',100);
commit;

select * from FA_ZEIT_FRAGE where 
    FA_ZEIT_FRAGE.DATUM = to_date(SYSDATE) and 
    FA_ZEIT_FRAGE.STUNDE = to_number(to_char(SYSDATE, 'HH24')) and 
    FA_ZEIT_FRAGE.MINUTE = to_number(to_char(SYSDATE, 'MI'));
    
    
select to_char(SYSDATE, 'HH24') from dual;



select FA_FRAGEN.* from FA_FRAGEN left join FA_ANTWORTEN on FA_ANTWORTEN.FRAGEN_ID = FA_FRAGEN.ID 
    and FA_ANTWORTEN.USER_ID_ANTWORT = 2 
    and FA_ANTWORTEN.BEWERTUNG is null
where FA_ANTWORTEN.ID is null or /*Keine Antwort abgegeben -> Left Join sorgt für Null*/
      FA_ANTWORTEN.BEWERTUNG < 50/*Frage abgegeben, bewertet und für schlecht befunden*/
;

select FA_FRAGEN.* FROM(
    select 
        F.ID AS FRAGEN_ID,
        (select MAX(FA_ANTWORTEN.BEWERTUNG) from FA_ANTWORTEN 
           where FA_ANTWORTEN.FRAGEN_ID = F.ID and FA_ANTWORTEN.USER_ID_ANTWORT = 2) as MAX_BEWERTUNG,
        (select COUNT(*) from FA_ANTWORTEN 
           where FA_ANTWORTEN.FRAGEN_ID = F.ID and FA_ANTWORTEN.USER_ID_ANTWORT = 2 and FA_ANTWORTEN.BEWERTUNG IS NULL) as ANZ_IN_BEARBEITUNG
        from FA_FRAGEN F) Q
inner join FA_FRAGEN on FA_FRAGEN.ID = Q.FRAGEN_ID
where (Q.MAX_BEWERTUNG is null or Q.MAX_BEWERTUNG < 50) and Q.ANZ_IN_BEARBEITUNG = 0;

select 
    F.ID AS FRAGEN_ID,
    (select MAX(FA_ANTWORTEN.BEWERTUNG) from FA_ANTWORTEN 
       where FA_ANTWORTEN.FRAGEN_ID = F.ID and FA_ANTWORTEN.USER_ID_ANTWORT = 2) as MAX_BEWERTUNG,
    (select COUNT(*) from FA_ANTWORTEN 
       where FA_ANTWORTEN.FRAGEN_ID = F.ID and FA_ANTWORTEN.USER_ID_ANTWORT = 2 and FA_ANTWORTEN.BEWERTUNG IS NULL) as ANZ_IN_BEARBEITUNG
    from FA_FRAGEN F;


 
select FA_ANTWORTEN.*, 
       FA_USER.FIRSTNAME AS ANTWORTER_VORNAME, 
       FA_USER.LASTNAME AS ANTWORTER_NACHNAME, 
       FA_FRAGEN.TEXT AS FRAGE_TEXT
from FA_ANTWORTEN 
inner join FA_FRAGEN on FA_ANTWORTEN.FRAGEN_ID = FA_FRAGEN.ID
inner join FA_USER on FA_ANTWORTEN.USER_ID_ANTWORT = FA_USER.ID
where FA_FRAGEN.USER_ID = 1 AND FA_ANTWORTEN.USER_ID_BEWERTUNG is null;


create dimension FA_ZEIT_FRAGE
level JAHR is FA_ZEIT_FRAGE.JAHR
level MONAT is FA_ZEIT_FRAGE.MONAT
level TAG is FA_ZEIT_FRAGE.TAG
level STUNDE is FA_ZEIT_FRAGE.STUNDE
level MINUTE is FA_ZEIT_FRAGE.MINUTE
hierarchy FA_ZEIT_FRAGE_ROLLUP(
    MINUTE child of
    STUNDE child of
    TAG child Of
    MONAT child Of
    JAHR
);

create dimension FA_ZEIT_ANTWORT
level JAHR is FA_ZEIT_ANTWORT.JAHR
level MONAT is FA_ZEIT_ANTWORT.MONAT
level TAG is FA_ZEIT_ANTWORT.TAG
level STUNDE is FA_ZEIT_ANTWORT.STUNDE
level MINUTE is FA_ZEIT_ANTWORT.MINUTE
hierarchy FA_ZEIT_ANTWORT_ROLLUP(
    MINUTE child of
    STUNDE child of
    TAG child Of
    MONAT child Of
    JAHR
);


select (sum(FA_ANTWORTEN.BEWERTUNG) / count(*)) as AVG_BEWERTUNG, FA_USER.ID from FA_ANTWORTEN 
inner join FA_USER on FA_ANTWORTEN.USER_ID_ANTWORT = FA_USER.ID
group by FA_USER.ID;

select median(FA_ZEIT_ANTWORT.NUM - FA_ZEIT_FRAGE.NUM) from FA_ANTWORTEN 
inner join FA_FRAGEN on FA_ANTWORTEN.FRAGEN_ID = FA_FRAGEN.ID
inner join FA_ZEIT_ANTWORT on FA_ANTWORTEN.ZEIT_ANTWORT_ID = FA_ZEIT_ANTWORT.ID
inner join FA_ZEIT_FRAGE on FA_FRAGEN.ZEIT_FRAGE_ID = FA_ZEIT_FRAGE.ID
group by FA_ANTWORTEN.USER_ID_ANTWORT;

select count(*) from FA_ANTWORTEN 
inner join FA_USER on FA_ANTWORTEN.USER_ID_ANTWORT = FA_USER.ID
where FA_ANTWORTEN.BEWERTUNG is not null and FA_ANTWORTEN.BEWERTUNG >= 50
group by FA_USER.GESCHLECHT
