drop table elevi cascade constraints;
/
drop table materii cascade constraints;
/
drop table note cascade constraints;
/
drop table profesori cascade constraints;
/
drop table didactic cascade constraints;
/
drop table cont cascade constraints;
/
drop table absente cascade constraints;
/

create table elevi (
    nr_matricol int not null primary key,
    nume varchar2(15) not null,
    prenume varchar2(30) not null,
    clasa int,
    profil varchar2(10),
    bursa number(6,2),
    data_nastere date,
    email varchar2(40)
);
/

create table materii (
    id_materie int not null primary key,
    titlu varchar2(60) not null,
    profil varchar2(10)
);
/

create table note (
    id_elev int not null,
    id_materie int not null,
    valoare number(2),
    data_notare date,
    constraint fk_note_id_elev foreign key (id_elev) references elevi(nr_matricol),
    constraint fk_note_id_curs foreign key (id_materie) references materii(id_materie)
);
/

create table profesori (
    id_profesor int not null primary key,
    nume varchar2(30) not null,
    prenume varchar2(40) not null,
    grad_didactic varchar2(20),
    diriginte varchar2(10),
    clasa int,
    meditator varchar2(10),
    data_meditatie date,
    ora int
);
/

create table didactic (
    id_profesor int not null,
    id_materie int not null,
    constraint fk_didactic_id_profesor foreign key (id_profesor) references profesori(id_profesor),
    constraint fk_didactic_id_materie foreign key (id_materie) references materii(id_materie)
);
/

create table cont (
        id_cont int not null primary key,
        username varchar2(40) not null,
        parola varchar2(40) not null
);
/

create table absente (
    id_elev int not null,
    id_materie int not null,
    data_abs date,
    constraint fk_absente_id_elev foreign key (id_elev) references elevi(nr_matricol),
    constraint fk_absente_id_curs foreign key (id_materie) references materii(id_materie)
);
/

/*
drop index elevi_nume;
/
drop index valoare_note;
/
create index elevi_nume on elevi (nume);
/
create index valoare_note on note (valoare);
*/

set serveroutput on;
declare
type varr is varray(1000) of varchar2(255);
lista_nume varr := varr('Ababei','Acasandrei','Adascalitei','Afanasie','Agafitei','Agape','Aioanei','Alexandrescu','Alexandru','Alexe','Alexii','Amarghioalei','Ambroci','Andonesei','Andrei','Andrian','Andrici','Andronic','Andros','Anghelina','Anita','Antochi','Antonie','Apetrei','Apostol','Arhip','Arhire','Arteni','Arvinte','Asaftei','Asofiei','Aungurenci','Avadanei','Avram','Babei','Baciu','Baetu','Balan','Balica','Banu','Barbieru','Barzu','Bazgan','Bejan','Bejenaru','Belcescu','Belciuganu','Benchea','Bilan','Birsanu','Bivol','Bizu','Boca','Bodnar','Boistean','Borcan','Bordeianu','Botezatu','Bradea','Braescu','Budaca','Bulai','Bulbuc-aioanei','Burlacu','Burloiu','Bursuc','Butacu','Bute','Buza','Calancea','Calinescu','Capusneanu','Caraiman','Carbune','Carp','Catana','Catiru','Catonoiu','Cazacu','Cazamir','Cebere','Cehan','Cernescu','Chelaru','Chelmu','Chelmus','Chibici','Chicos','Chilaboc','Chile','Chiriac','Chirila','Chistol','Chitic','Chmilevski','Cimpoesu','Ciobanu','Ciobotaru','Ciocoiu','Ciofu','Ciornei','Citea','Ciucanu','Clatinici','Clim','Cobuz','Coca','Cojocariu','Cojocaru','Condurache','Corciu','Corduneanu','Corfu','Corneanu','Corodescu','Coseru','Cosnita','Costan','Covatariu','Cozma','Cozmiuc','Craciunas','Crainiceanu','Creanga','Cretu','Cristea','Crucerescu','Cumpata','Curca','Cusmuliuc','Damian','Damoc','Daneliuc','Daniel','Danila','Darie','Dascalescu','Dascalu','Diaconu','Dima','Dimache','Dinu','Dobos','Dochitei','Dochitoiu','Dodan','Dogaru','Domnaru','Dorneanu','Dragan','Dragoman','Dragomir','Dragomirescu','Duceac','Dudau','Durnea','Edu','Eduard','Eusebiu','Fedeles','Ferestraoaru','Filibiu','Filimon','Filip','Florescu','Folvaiter','Frumosu','Frunza','Galatanu','Gavrilita','Gavriliuc','Gavrilovici','Gherase','Gherca','Ghergu','Gherman','Ghibirdic','Giosanu','Gitlan','Giurgila','Glodeanu','Goldan','Gorgan','Grama','Grigore','Grigoriu','Grosu','Grozavu','Gurau','Haba','Harabula','Hardon','Harpa','Herdes','Herscovici','Hociung','Hodoreanu','Hostiuc','Huma','Hutanu','Huzum','Iacob','Iacobuta','Iancu','Ichim','Iftimesei','Ilie','Insuratelu','Ionesei','Ionesi','Ionita','Iordache','Iordache-tiroiu','Iordan','Iosub','Iovu','Irimia','Ivascu','Jecu','Jitariuc','Jitca','Joldescu','Juravle','Larion','Lates','Latu','Lazar','Leleu','Leon','Leonte','Leuciuc','Leustean','Luca','Lucaci','Lucasi','Luncasu','Lungeanu','Lungu','Lupascu','Lupu','Macariu','Macoveschi','Maftei','Maganu','Mangalagiu','Manolache','Manole','Marcu','Marinov','Martinas','Marton','Mataca','Matcovici','Matei','Maties','Matrana','Maxim','Mazareanu','Mazilu','Mazur','Melniciuc-puica','Micu','Mihaela','Mihai','Mihaila','Mihailescu','Mihalachi','Mihalcea','Mihociu','Milut','Minea','Minghel','Minuti','Miron','Mitan','Moisa','Moniry-abyaneh','Morarescu','Morosanu','Moscu','Motrescu','Motroi','Munteanu','Murarasu','Musca','Mutescu','Nastaca','Nechita','Neghina','Negrus','Negruser','Negrutu','Nemtoc','Netedu','Nica','Nicu','Oana','Olanuta','Olarasu','Olariu','Olaru','Onu','Opariuc','Oprea','Ostafe','Otrocol','Palihovici','Pantiru','Pantiruc','Paparuz','Pascaru','Patachi','Patras','Patriche','Perciun','Perju','Petcu','Pila','Pintilie','Piriu','Platon','Plugariu','Podaru','Poenariu','Pojar','Popa','Popescu','Popovici','Poputoaia','Postolache','Predoaia','Prisecaru','Procop','Prodan','Puiu','Purice','Rachieru','Razvan','Reut','Riscanu','Riza','Robu','Roman','Romanescu','Romaniuc','Rosca','Rusu','Samson','Sandu','Sandulache','Sava','Savescu','Schifirnet','Scortanu','Scurtu','Sfarghiu','Silitra','Simiganoschi','Simion','Simionescu','Simionesei','Simon','Sitaru','Sleghel','Sofian','Soficu','Sparhat','Spiridon','Stan','Stavarache','Stefan','Stefanita','Stingaciu','Stiufliuc','Stoian','Stoica','Stoleru','Stolniceanu','Stolnicu','Strainu','Strimtu','Suhani','Tabusca','Talif','Tanasa','Teclici','Teodorescu','Tesu','Tifrea','Timofte','Tincu','Tirpescu','Toader','Tofan','Toma','Toncu','Trifan','Tudosa','Tudose','Tuduri','Tuiu','Turcu','Ulinici','Unghianu','Ungureanu','Ursache','Ursachi','Urse','Ursu','Varlan','Varteniuc','Varvaroi','Vasilache','Vasiliu','Ventaniuc','Vicol','Vidru','Vinatoru','Vlad','Voaides','Vrabie','Vulpescu','Zamosteanu','Zazuleac');
lista_prenume_fete varr := varr('Adina','Alexandra','Alina','Ana','Anca','Anda','Andra','Andreea','Andreia','Antonia','Bianca','Camelia','Claudia','Codrina','Cristina','Daniela','Daria','Delia','Denisa','Diana','Ecaterina','Elena','Eleonora','Elisa','Ema','Emanuela','Emma','Gabriela','Georgiana','Ileana','Ilona','Ioana','Iolanda','Irina','Iulia','Iuliana','Larisa','Laura','Loredana','Madalina','Malina','Manuela','Maria','Mihaela','Mirela','Monica','Oana','Paula','Petruta','Raluca','Sabina','Sanziana','Simina','Simona','Stefana','Stefania','Tamara','Teodora','Theodora','Vasilica','Xena');
lista_prenume_baieti varr := varr('Adrian','Alex','Alexandru','Alin','Andreas','Andrei','Aurelian','Beniamin','Bogdan','Camil','Catalin','Cezar','Ciprian','Claudiu','Codrin','Constantin','Corneliu','Cosmin','Costel','Cristian','Damian','Dan','Daniel','Danut','Darius','Denise','Dimitrie','Dorian','Dorin','Dragos','Dumitru','Eduard','Elvis','Emil','Ervin','Eugen','Eusebiu','Fabian','Filip','Florian','Florin','Gabriel','George','Gheorghe','Giani','Giulio','Iaroslav','Ilie','Ioan','Ion','Ionel','Ionut','Iosif','Irinel','Iulian','Iustin','Laurentiu','Liviu','Lucian','Marian','Marius','Matei','Mihai','Mihail','Nicolae','Nicu','Nicusor','Octavian','Ovidiu','Paul','Petru','Petrut','Radu','Rares','Razvan','Richard','Robert','Roland','Rolland','Romanescu','Sabin','Samuel','Sebastian','Sergiu','Silviu','Stefan','Teodor','Teofil','Theodor','Tudor','Vadim','Valentin','Valeriu','Vasile','Victor','Vlad','Vladimir','Vladut');
lista_materii varr := varr('Matematica', 'Limba si literatura romana', 'Chimie', 'Biologie', 'Desen', 'Muzica', 'Geografie', 'Educatie Tehnologica', 'Informatica', 'Fizica', 'Educatie Civica', 'Educatie antreprenoriala', 'Logica', 'Psihologie', 'Sport', 'TIC', 'Religie', 'Optional', 'Sah');
lista_grade_didactice varr := varr('I', 'II', 'II', 'Suplinitor', 'Practicant');
lista_profil varr := varr('Real', 'Uman', 'Niciunul', 'Oricare');

v_nume varchar2(255);
v_prenume varchar2(255);
v_prenume1 varchar2(255);
v_prenume2 varchar2(255);
v_clasa int;
v_bursa int;
v_data_nastere date;
v_email varchar2(40);
v_username varchar2(40);
v_matr int;
v_temp int;
v_profil varchar2(20);
cursor lista_elevi is select nr_matricol from elevi;
cursor cont1 is select nume||prenume from elevi;
cursor cont2 is select nume||prenume from profesori;
cursor lista_profesori is select id_profesor from profesori;
v_nr int;
v_data_notare date;
v_valoare int;
v_i int;
v_cont1 varchar2(60);
v_cont2 varchar2(60);
v_parola varchar(60);
v_prof int;
v_ora int;
v_diriginte varchar2(10);
v_meditator varchar2(10);
v_data date;

begin

DBMS_OUTPUT.PUT_LINE('Inserare elevilor...');

for v_i in 1..1000000 loop
    v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_prenume1 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
         LOOP
            v_prenume2 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;
       ELSE
         v_prenume1 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
         LOOP
            v_prenume2 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;       
       END IF;
     
     IF (DBMS_RANDOM.VALUE(0,100)<60) THEN  
        IF LENGTH(v_prenume1 || ' ' || v_prenume2) <= 20 THEN
          v_prenume := v_prenume1 || ' ' || v_prenume2;
        END IF;
        else 
           v_prenume:=v_prenume1;
      END IF;       
       
        LOOP
         v_matr := v_i;
         select count(*) into v_temp from elevi where nr_matricol = v_matr;
         exit when v_temp=0;
        END LOOP;

    v_clasa := trunc(dbms_random.value(0,12))+1;
    v_bursa := '';
      IF (DBMS_RANDOM.VALUE(0,100)<10) THEN
         v_bursa := TRUNC(DBMS_RANDOM.VALUE(0,10))*100 + 500;
      END IF;
      
      v_data_nastere := TO_DATE('01-01-1998','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
      
      v_temp:='';
      v_email := lower(v_nume ||'.'|| v_prenume1);  
      if (TRUNC(DBMS_RANDOM.VALUE(0,2))=0) then v_email := v_email ||'@gmail.com';
         else v_email := v_email ||'@yahoo.ro';
      end if;
                      
        v_profil := lista_profil(TRUNC(DBMS_RANDOM.VALUE(0,lista_profil.count))+1);
      insert into elevi values(v_matr, v_nume, v_prenume, v_clasa, v_profil, v_bursa, v_data_nastere, v_email);
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('Inserarea elevilor... GATA !');
   
   DBMS_OUTPUT.PUT_LINE('Inserarea matreriilor...');
   for v_i in 1..19 loop
   v_profil := lista_profil(TRUNC(DBMS_RANDOM.VALUE(0,lista_profil.count))+1);
   insert into materii values (v_i, lista_materii(v_i),v_profil);
   end loop;
   DBMS_OUTPUT.PUT_LINE('Inserarea matreriilor... GATA !');  

    DBMS_OUTPUT.PUT_LINE('Inserare profesori...');
   FOR v_i IN 1000000..1100000 LOOP
      v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_prenume1 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
         LOOP
            v_prenume2 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;
       ELSE
         v_prenume1 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
         LOOP
            v_prenume2 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;       
       END IF;
       
       IF (DBMS_RANDOM.VALUE(0,100)<60) THEN  
          IF LENGTH(v_prenume1 || ' ' || v_prenume2) <= 20 THEN
            v_prenume := v_prenume1 || ' ' || v_prenume2;
          END IF;
          else 
             v_prenume:=v_prenume1;
        END IF;      
        v_data := NULL;
        if(DBMS_RANDOM.VALUE(0,100)<5) THEN
            if(DBMS_RANDOM.VALUE(0,10)<5) THEN  
            v_diriginte := 'DA';
            v_meditator := 'NU';
            else 
            v_diriginte := 'NU';
            v_meditator := 'DA';
            end if;
            if(v_diriginte='DA') then
            v_clasa := TRUNC(DBMS_RANDOM.VALUE(0,11))+1;
            else 
            v_clasa := 0;
            end if;
            if(v_meditator='DA') then
            v_ora := TRUNC(DBMS_RANDOM.VALUE(0,23))+1;
            v_data := TO_DATE('01-01-2019','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
            else 
            v_ora := 0;
            end if;
        else 
        v_diriginte := '0';
        v_meditator := '0';
        v_clasa := 0;
        v_ora := 0;
        end if;
        INSERT INTO profesori values (v_i, v_nume, v_prenume, lista_grade_didactice(TRUNC(DBMS_RANDOM.VALUE(0,5))+1), v_diriginte, v_clasa, v_meditator, v_data, v_ora);       
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Inserare profesori... GATA!');  
   
    DBMS_OUTPUT.PUT_LINE('Inserare note');
    open lista_elevi;
    loop
    fetch lista_elevi into v_nr;
    exit when lista_elevi%notfound;
    v_i := TRUNC(DBMS_RANDOM.VALUE(0,18))+1;
    v_valoare := TRUNC(DBMS_RANDOM.VALUE(0,10))+1;
    v_data_notare := TO_DATE('01-01-2019','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
    insert into note values(v_nr, v_i, v_valoare, v_data_notare);
    --v_valoare := TRUNC(DBMS_RANDOM.VALUE(0,10))+1;
    --insert into note values(v_nr, v_i, v_valoare, v_data_notare);
    end loop;
    close lista_elevi;
    DBMS_OUTPUT.PUT_LINE('Inserare note...GATA!');
 
    DBMS_OUTPUT.PUT_LINE('Inserare absente');
    open lista_elevi;
    loop
    fetch lista_elevi into v_nr;
    exit when lista_elevi%notfound;
    if(TRUNC(DBMS_RANDOM.VALUE(0,100))<30) then
    v_i := TRUNC(DBMS_RANDOM.VALUE(0,18))+1;
    v_data_notare := TO_DATE('01-01-2019','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
    insert into absente values(v_nr, v_i, v_data_notare);
    end if;
    end loop;
    close lista_elevi;
    DBMS_OUTPUT.PUT_LINE('Inserare absente...GATA!');

    DBMS_OUTPUT.PUT_LINE('Inserare conturi');
    open cont1;
    v_i:=1;
    loop
    fetch cont1 into v_cont1;
    exit when cont1%notfound;
    insert into cont values(v_i, v_cont1, v_cont1);
    v_i:=v_i+1;
    end loop;
    close cont1;
    open cont2;
    loop
    fetch cont2 into v_cont2;
    exit when cont2%notfound;
    insert into cont values(v_i, v_cont2, v_cont2);
    v_i:=v_i+1;
    end loop;
    close cont2;
    DBMS_OUTPUT.PUT_LINE('Inserare conturi...GATA!');
/*
    DBMS_OUTPUT.PUT_LINE('Asocierea profesorilor cu cursurile...');
    open lista_profesori;
    loop
    fetch lista_profesori into v_prof;
    INSERT INTO didactic values(v_prof, (TRUNC(DBMS_RANDOM.VALUE(0,18))+1));
    END LOOP;
    close lista_profesori;
    DBMS_OUTPUT.PUT_LINE('Asocierea profesorilor cu cursurile... GATA!');      
*/
end;
/
select count(*)|| ' studenti inserati' from elevi;
select count(*)|| ' profi inserati' from profesori;
select count(*)|| ' conturi' from cont;
select count(*)|| ' note' from note;
select count(*)|| ' absente' from absente;
select count(*)|| ' materii' from materii;


--select * from elevi;
--select * from materii;
--select * from profesori;
--select * from note;
--select * from absente;
select * from cont;