CREATE TABLE Locatie
(
    id_locatie number(3) constraint PK_Locatie primary key,
    tip varchar2(20) not null constraint Locatie_Verif_Tip_Locatie check(lower(tip) in ('fabrica', 'depozit')),
    strada varchar2(30) constraint Locatie_Verif_Adresa_Strada not null,
    cod_postal varchar2(10) constraint Locatie_Verif_Adresa_CP not null,
    oras varchar2(20) constraint Locatie_Verif_Adresa_Oras not null,
    tara varchar2(20) constraint Locatie_Verif_Adresa_Tara not null
);

CREATE TABLE Departament
(
    id_departament number(3) not null constraint PK_Departament primary key,
    id_locatie number(3),
    nume_departament varchar2(20) not null,
    id_manager number(3),
    
    constraint FK_Departament_Locatie foreign key (id_locatie) references Locatie (id_locatie) on delete set null
);

CREATE TABLE Angajat
(
    id_angajat number(3) constraint PK_Angajat primary key,
    id_manager number(3),
    id_departament number(3) not null,
    nume varchar2(20) not null,
    prenume varchar2(20) not null,
    email varchar2(20) not null constraint Angajat_Verif_Email_valid check(email like '%@gmail.com' OR email like '%@yahoo.com' OR email like '%@outlook.com'),
    nr_telefon varchar2(10) not null,
    data_angajare date not null,
    titlu_job varchar2(20) not null,
    salariu number(6) not null constraint Angajat_Verif_Salariu_Maxim check(salariu < 20000),
    
    constraint FK_Angajat_Manager foreign key(id_manager) references Angajat(id_angajat) on delete set null,
    constraint FK_Angajat_Departament foreign key(id_departament) references Departament(id_departament) on delete cascade
)

CREATE TABLE Istoric_Angajari
(
    id_angajare number(4) constraint PK_Istoric_Angajari primary key,
    id_angajat number(3) not null,
    id_departament number(3) not null,
    titlu_job varchar2(20) not null,
    data_inceput date not null,
    data_final date,
    
    constraint FK_Istoric_Angajari_Angajat foreign key(id_angajat) references Angajat(id_angajat),
    constraint FK_Istoric_Angajari_Departament foreign key(id_departament) references Departament(id_departament)
)

CREATE TABLE Utilaj
(
    id_utilaj number(4) constraint PK_Utilaj primary key,
    id_departament number(3),
    nume_utilaj varchar2(20) not null,
    model_utilaj varchar2(20) not null,
    
    constraint FK_Utilaj_Departament foreign key(id_departament) references Departament(id_departament) on delete cascade
)

CREATE TABLE Obiect
(
    id_obiect number(3) constraint PK_Obiect primary key,
    id_departament number(3),
    nume varchar2(30) not null,
    
    constraint FK_Obiect_Departament foreign key(id_departament) references Departament(id_departament) on delete set null
)

CREATE TABLE Client
(
    id_client number(3) constraint PK_Client primary key,
    id_obiect number(3),
    
    constraint FK_Client_Obiect foreign key(id_obiect) references Obiect(id_obiect) on delete set null
)

CREATE TABLE Comanda
(
    id_comanda number(5) constraint PK_Comanda primary key,
    id_client number(3),
    id_obiect number(3),
    masura varchar2(5) not null,
    nr_bucati number(4) not null,
    
    constraint FK_Comanda_Client foreign key(id_client) references Client(id_client) on delete cascade,
    constraint FK_Comanda_Obiect foreign key(id_obiect) references Obiect(id_obiect) on delete cascade
)

CREATE TABLE Furnizor
(
    id_furnizor number(3) constraint PK_Furnizor primary key
)

CREATE TABLE Material_Necesar
(
    id_obiect number(3) not null,
    masura varchar2(5) not null,
    id_material number(3),
    cantitate_necesara number(4, 2) not null,
    
    constraint PK_Material_Necesar primary key (id_obiect, masura),
    constraint FK_Material_Necesar foreign key(id_material) references Furnizor(id_furnizor) on delete cascade
)

INSERT INTO locatie
values(100, 'Fabrica', 'strada', '0202', 'Bucuresti', 'Romania');

delete from Locatie
Where id_locatie = 100;

drop table locatie;

commit;