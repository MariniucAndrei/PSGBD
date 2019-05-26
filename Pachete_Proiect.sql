drop package medie;
/
create or replace package medie as
function medie_elev(IN_nr_matricol in number)
return number;
function medie_clasa(IN_clasa in number)
return number;
function medie_materie(IN_id_materie in number)
return number;
function medie_scoala
return number;
end medie;
/
create or replace package body medie as
function medie_elev(IN_nr_matricol in number)
return number
as
medie number(38,0);
begin
select avg(valoare) into medie from note n
join elevi e on e.nr_matricol=n.id_elev where
n.id_elev=IN_nr_matricol;
return medie;
end;
function medie_clasa(IN_clasa in number)
return number
as
medie number(38,0);
begin
select avg(valoare) into medie from note n
join elevi e on e.nr_matricol=n.id_elev
group by e.clasa
having IN_clasa=e.clasa;
return medie;
end;
function medie_materie(IN_id_materie in number)
return number
as
medie number(38,0);
begin
select avg(valoare) into medie from note n
join materii m on m.id_materie=n.id_materie
group by m.id_materie
having IN_id_materie=m.id_materie;
return medie;
end;
function medie_scoala
return number
as
medie number(38,0);
begin
select avg(valoare) into medie from note;
return medie;
end;
end medie;
/
drop package absente1;
/
create or replace package absente1 as
function absente_elev(IN_id_elev in number)
return number;
function absente_scadere_elev
return number;
function absente_min_max_elev
return varchar2;
end absente1;
/
create or replace package body absente1 as
function absente_elev(IN_id_elev in number)
return number
as
abse number(38,0);
begin
select count(data_abs) into abse from absente a
join elevi e on e.nr_matricol=a.id_elev where
a.id_elev=IN_id_elev;
return abse;
end;
function absente_scadere_elev
return number
as
pct number(38,0);
begin
pct := absente1.absente_elev(1) / 10;
return pct;
end;
function absente_min_max_elev
return varchar2
as
id_min number;
id_max number;
v_nr number;
cursor lista_elevi is select nr_matricol from elevi;
begin
open lista_elevi;
loop
fetch lista_elevi into v_nr;
exit when lista_elevi%notfound;
if absente1.absente_elev(v_nr) < absente1.absente_elev(id_min) then
id_min := v_nr;
else 
if absente1.absente_elev(v_nr) > absente1.absente_elev(id_max) then
id_max := v_nr;
end if;
end if;
end loop;
close lista_elevi;
return id_min||' '||id_max;
end;
end absente1;
/
set serveroutput on;
declare
rezultat number(38,0);
begin
rezultat := absente1.absente_min_max_elev;
DBMS_OUTPUT.PUT_LINE(rezultat);
end;
/

drop table clasament_clase;
/
drop table clasament_indiv;
/
create  table  clasament_clase (
c int  ,media int );
/
create  table  clasament_indiv (
id int ,media int );
/
--drop package clasament;
--/
create or replace package clasament as 
procedure clasament_clasa;
procedure clasament_indiv;
end clasament;

/

create or replace package body clasament as
procedure clasament_clasa
as
m number;
cursor clas is
select clasa from elevi group by clasa; 
s number;
begin 
open clas;
loop 
FETCH clas into s;
m:=medie.medie_clasa(s);
insert into clasament_clase (c,media) values(s,m); 
EXIT WHEN clas%NOTFOUND;
end loop;
end;

procedure clasament_indiv
as
m number;
s number;
cursor el is select nr_matricol from elevi;
begin
open el;
loop 
FETCH el into s;
m:=medie.medie_elev(s);
insert into clasament_indiv (id,media) values(s,m); 
 EXIT WHEN el%NOTFOUND;
end loop;
end;

end;
/
set serveroutput on;
begin 
--clasament.clasament_clasa;
clasament.clasament_indiv;
end;
/
select * from clasament_indiv;
/
select * from clasament_clase;
/

DROP PACKAGE Profi;
/
create or replace PACKAGE Profi as 
procedure insert_prof(IN_id IN profesori.id_profesor%type,
IN_nume IN profesori.nume%type,
IN_prenume IN profesori.prenume%type,
IN_grad IN profesori.grad_didactic%type,
IN_dirig IN profesori.diriginte%type,
IN_clasa IN profesori.clasa%type,
IN_meditator IN profesori.meditator%type,
IN_data IN profesori.data_meditatie%type,
IN_ora IN profesori.ora%type);
procedure update_prof_dirig (IN_id IN profesori.id_profesor%type,
IN_dirig IN profesori.diriginte%type,IN_clasa IN profesori.clasa%type);
procedure update_prof_mentor (IN_id IN profesori.id_profesor%type,
IN_meditator IN profesori.meditator%type,IN_data IN profesori.data_meditatie%type,
IN_ora IN profesori.ora%type
);
procedure delete_prof(IN_id IN profesori.id_profesor%type);
end ;
/
create or replace PACKAGE BODY Profi AS
procedure insert_prof(IN_id IN profesori.id_profesor%type,
IN_nume IN profesori.nume%type,
IN_prenume IN profesori.prenume%type,
IN_grad IN profesori.grad_didactic%type,
IN_dirig IN profesori.diriginte%type,
IN_clasa IN profesori.clasa%type,
IN_meditator IN profesori.meditator%type,
IN_data IN profesori.data_meditatie%type,
IN_ora IN profesori.ora%type
) as
begin
insert into profesori(id_profesor,nume,prenume,grad_didactic,diriginte,clasa,meditator,data_meditatie,ora)  VALUES (IN_id,IN_nume,IN_prenume,
IN_grad,IN_dirig,IN_clasa,IN_meditator,IN_data,IN_ora);
end;
procedure update_prof_dirig (IN_id IN profesori.id_profesor%type,
IN_dirig IN profesori.diriginte%type,IN_clasa IN profesori.clasa%type) as
begin
UPDATE profesori
SET diriginte = IN_dirig,
clasa=IN_clasa
WHERE id_profesor=IN_id;
end;
procedure update_prof_mentor(IN_id IN profesori.id_profesor%type,
IN_meditator IN profesori.meditator%type,IN_data IN profesori.data_meditatie%type,
IN_ora IN profesori.ora%type
) as
begin
UPDATE profesori
SET meditator = IN_meditator,
data_meditatie=IN_data,
ora=IN_ora
WHERE id_profesor=IN_id;
end;
procedure delete_prof(IN_id IN profesori.id_profesor%type) as
begin
delete from profesori where id_profesor=IN_id;
end;
end;
/
set serveroutput on;
begin 
profi.update_prof_mentor(2,1,sysdate,13);
--clasament.clasament_indiv;
end;

/
select * from profesori where id_profesor=2;
/

DROP PACKAGE notare;
/
create or replace PACKAGE notare as 
procedure insert_nota(IN_id IN note.id_elev%type,
IN_id_mat IN note.id_materie%type,
IN_val IN note.valoare%type,
IN_data IN note.data_notare%type);
procedure update_nota (IN_id IN note.id_elev%type,
IN_id_mat IN note.id_materie%type,
IN_val IN note.valoare%type,
IN_data IN note.data_notare%type
);
procedure delete_nota(IN_id IN note.id_elev%type,
IN_id_mat IN note.id_materie%type,
IN_val IN note.valoare%type,
IN_data IN note.data_notare%type);
end ;
/
create or replace PACKAGE BODY notare AS
procedure insert_nota(IN_id IN note.id_elev%type,
IN_id_mat IN note.id_materie%type,
IN_val IN note.valoare%type,
IN_data IN note.data_notare%type
) as
mesaj VARCHAR2(32767);
begin
insert into note(id_elev, id_materie, valoare, data_notare)  VALUES (IN_id,IN_id_mat,IN_val,IN_data);
--exception
--when value_error then
--if IN_val<1 and IN_val>10 then
--mesaj := 'Nota invalida';
--endif;
--return mesaj;
end;
procedure update_nota(IN_id IN note.id_elev%type,
IN_id_mat IN note.id_materie%type,
IN_val IN note.valoare%type,
IN_data IN note.data_notare%type) as
begin
UPDATE note
SET valoare = IN_val
WHERE (id_elev=IN_id and id_materie=IN_id_mat and data_notare=IN_data);
end;
procedure delete_nota(IN_id IN note.id_elev%type,
IN_id_mat IN note.id_materie%type,
IN_val IN note.valoare%type,
IN_data IN note.data_notare%type) as
begin
delete from note where id_elev=IN_id and id_materie=IN_id_mat and data_notare=IN_data and valoare=IN_val;
end;
end;
/

set serveroutput on;
begin 
--notare.update_nota(1,4,10,sysdate);
notare.insert_nota(1,2,11,sysdate);
--notare.delete_nota(1,2,3,sysdate);
end;

/
select * from note where id_elev=1;
/


DROP PACKAGE absenta;
/
create or replace PACKAGE absenta as 
procedure insert_absenta(IN_id IN absente.id_elev%type,
IN_id_mat IN absente.id_materie%type,
IN_data IN absente.data_abs%type);
procedure delete_absenta(IN_id IN absente.id_elev%type,
IN_id_mat IN absente.id_materie%type,
IN_data IN absente.data_abs%type);
end;
/
create or replace PACKAGE BODY absenta AS
procedure insert_absenta(IN_id IN absente.id_elev%type,
IN_id_mat IN absente.id_materie%type,
IN_data IN absente.data_abs%type
) as
begin
insert into absente(id_elev, id_materie, data_abs)  VALUES (IN_id,IN_id_mat,IN_data);
end;
procedure delete_absenta(IN_id IN absente.id_elev%type,
IN_id_mat IN absente.id_materie%type,
IN_data IN absente.data_abs%type) as
begin
delete from absente where id_elev=IN_id and id_materie=IN_id_mat and data_abs=IN_data;
end;
end;
/

set serveroutput on;
begin 
absenta.insert_absenta(1,2,sysdate);
--absenta.delete_absenta(1,2,sysdate);
end;

/
select * from absente where id_elev=1;
/

DROP PACKAGE elev;
/
create or replace PACKAGE elev as 
procedure insert_elev(IN_id IN elevi.nr_matricol%type,
IN_nume IN elevi.nume%type,
IN_prenume IN elevi.prenume%type,
IN_clasa IN elevi.clasa%type,
IN_profil IN elevi.profil%type,
IN_bursa IN elevi.bursa%type,
IN_data IN elevi.data_nastere%type,
IN_email IN elevi.email%type);
procedure update_elev(IN_id IN elevi.nr_matricol%type, IN_clasa IN elevi.clasa%type);
procedure delete_elev(IN_id IN elevi.nr_matricol%type);
end ;
/
create or replace PACKAGE BODY elev AS
procedure insert_elev(IN_id IN elevi.nr_matricol%type,
IN_nume IN elevi.nume%type,
IN_prenume IN elevi.prenume%type,
IN_clasa IN elevi.clasa%type,
IN_profil IN elevi.profil%type,
IN_bursa IN elevi.bursa%type,
IN_data IN elevi.data_nastere%type,
IN_email IN elevi.email%type
) as
begin
insert into elevi(nr_matricol,nume,prenume,clasa,profil,bursa,data_nastere,email)  VALUES (IN_id,IN_nume,IN_prenume,
IN_clasa,IN_profil,IN_bursa,IN_data,IN_email);
end;
procedure update_elev(IN_id IN elevi.nr_matricol%type, IN_clasa IN elevi.clasa%type) as
begin
UPDATE elevi
SET clasa = IN_clasa
WHERE nr_matricol=IN_id;
end;
procedure delete_elev(IN_id IN elevi.nr_matricol%type) as
begin
delete from elevi where nr_matricol=IN_id;
end;
end;
/
set serveroutput on;
begin 
--elev.insert_elev(1000001,'Andrei','Ma',12,'real',580,sysdate,'andrei.mariniuc@gmail.com');
--elev.update_elev(1000001,5);
elev.delete_elev(1000001);
end;

/
select * from elevi where nr_matricol=1000001;
/
