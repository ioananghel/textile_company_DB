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

alter table departament
modify nume_departament varchar2(50);

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
);

alter table angajat
modify email varchar2(40);
alter table angajat
modify nr_telefon varchar2(20);
alter table angajat
modify titlu_job varchar2(40);

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
);
alter table istoric_angajari
modify titlu_job varchar2(40);

CREATE TABLE Utilaj
(
    id_utilaj number(4) constraint PK_Utilaj primary key,
    id_departament number(3),
    nume_utilaj varchar2(20) not null,
    model_utilaj varchar2(20) not null,
    
    constraint FK_Utilaj_Departament foreign key(id_departament) references Departament(id_departament) on delete cascade
);

alter table Utilaj
modify nume_utilaj varchar2(30);
alter table Utilaj
modify model_utilaj varchar2(30);

CREATE TABLE Obiect
(
    id_obiect number(3) constraint PK_Obiect primary key,
    id_departament number(3),
    nume varchar2(30) not null,
    
    constraint FK_Obiect_Departament foreign key(id_departament) references Departament(id_departament) on delete set null
);

alter table obiect
modify nume varchar2(50);

CREATE TABLE Client
(
    id_client number(3) constraint PK_Client primary key,
    id_obiect number(3),
    
    constraint FK_Client_Obiect foreign key(id_obiect) references Obiect(id_obiect) on delete set null
);

alter table Client
add nume varchar2(30) not null;

CREATE TABLE Comanda
(
    id_comanda number(5) constraint PK_Comanda primary key,
    id_client number(3),
    id_obiect number(3),
    masura varchar2(5) not null,
    nr_bucati number(4) not null,
    
    constraint FK_Comanda_Client foreign key(id_client) references Client(id_client) on delete cascade,
    constraint FK_Comanda_Obiect foreign key(id_obiect) references Obiect(id_obiect) on delete cascade
);

CREATE TABLE Furnizor
(
    id_furnizor number(3) constraint PK_Furnizor primary key,
    nume varchar2(20) not null
);

CREATE TABLE Material_Necesar
(
    id_obiect number(5) not null,
    masura varchar2(8) not null,
    id_material number(5),
    cantitate_necesara number(5) not null,
    
    constraint PK_Material_Necesar primary key (id_obiect, masura, id_material),
    constraint FK_Material_Necesar foreign key(id_material) references Furnizor(id_furnizor) on delete cascade
);
--drop table material_necesar;

---INSERT LOCATII
INSERT INTO locatie
values(0, 'Fabrica', 'Strada Dinu Vintila 2', '021101', 'Bucuresti', 'Romania');
INSERT INTO locatie
values(1, 'Fabrica', 'Bulevardul Lacul Tei 124', '020396', 'Bucuresti', 'Romania');
INSERT INTO locatie
values(2, 'Fabrica', 'Soseaua Bucuresti-Ploiesti18', '077015', 'Balotesti', 'Romania');
INSERT INTO locatie
values(3, 'Depozit', 'Soseaua Colentina 10', '021174', 'Bucuresti', 'Romania');

---INSERT DEPARTAMENTE
INSERT INTO Departament values(1, 0, 'Ingineria si Designul Combinezoanelor', 1);
INSERT INTO Departament values(3, 0, 'Ingineria Chimica', 3);

INSERT INTO Departament values(2, 1, 'Ingineria si Designul Costumelor One-Piece', 2);

INSERT INTO Departament values(0, 2, 'Management', 0);
INSERT INTO Departament values(4, 2, 'Confectii Accesorii', 4);

INSERT INTO Departament values(5, 3, 'Intretinere Gestionare Depozit', 5);

---INSERT ANGAJATI
INSERT INTO Angajat values(0, 0, 0, 'Pop', 'Ioan', 'Ioan_Pop@gmail.com', '+40 729 123 456', TO_DATE('11-11-2019', 'dd-mm-yyyy'), 'Manager', 15000);
INSERT INTO Angajat values(1, 1, 1, 'Ionescu', 'Mihai', 'Mihai_Ionescu@yahoo.com', '+40 721 345 678', TO_DATE('15-09-2020', 'dd-mm-yyyy'), 'Manager', 15000);
INSERT INTO Angajat values(2, 2, 2, 'Dumitrescu', 'Elena', 'Elena_Dumitrescu@outlook.com', '+40 754 321 678', TO_DATE('25-11-2022', 'dd-mm-yyyy'), 'Manager', 15000);
INSERT INTO Angajat values(3, 3, 3, 'Stefan', 'Ioana', 'Ioana_Stefan@gmail.com', '+40 762 543 210', TO_DATE('10-09-2018', 'dd-mm-yyyy'), 'Manager', 15000);
INSERT INTO Angajat values(4, 4, 4, 'Matei', 'Alexandru', 'Alexandru_Matei@yahoo.com', '+40 732 145 678', TO_DATE('16-12-2021', 'dd-mm-yyyy'), 'Manager', 15000);
INSERT INTO Angajat values(5, 5, 5, 'Neagu', 'Raluca', 'Raluca_Neagu@outlook.com', '+40 786 210 345', TO_DATE('18-05-2021', 'dd-mm-yyyy'), 'Manager', 15000);
INSERT INTO Angajat values(6, 0, 0, 'Dobre', 'Cristina', 'Cristina_Dobre@gmail.com', '+40 756 432 210', TO_DATE('15-02-2019', 'dd-mm-yyyy'), 'Secretar', 6000);
INSERT INTO Angajat values(7, 0, 0, 'Ciobanu', 'Catalin', 'Catalin_Ciobanu@yahoo.com', '+40 723 210 345', TO_DATE('12-01-2020', 'dd-mm-yyyy'), 'Director Relatii cu Clientii', 8000);
INSERT INTO Angajat values(8, 1, 1, 'Stan', 'Andreea', 'Andreea_Stan@outlook.com', '+40 771 345 678', TO_DATE('14-08-2020', 'dd-mm-yyyy'), 'Inginer textile', 12000);
INSERT INTO Angajat values(9, 1, 1, 'Gheorghe', 'Irina', 'Irina_Gheorghe@gmail.com', '+40 781 210 345', TO_DATE('04-06-2022', 'dd-mm-yyyy'), 'Designer textile', 9000);
INSERT INTO Angajat values(10, 1, 1, 'Mirea', 'Mirela', 'Mirela_Mirea@yahoo.com', '+40 735 210 345', TO_DATE('19-04-2018', 'dd-mm-yyyy'), 'Operator Utilaje', 7000);
INSERT INTO Angajat values(11, 1, 1, 'Ivan', 'Marius', 'Marius_Ivan@outlook.com', '+40 798 210 345', TO_DATE('20-10-2021', 'dd-mm-yyyy'), 'Croitor', 8000);
INSERT INTO Angajat values(12, 3, 3, 'Vasile', 'Bogdan', 'Bogdan_Vasile@gmail.com', '+40 736 210 345', TO_DATE('31-08-2022', 'dd-mm-yyyy'), 'Inginer chimist', 13000);
INSERT INTO Angajat values(13, 3, 3, 'Bogdan', 'Oana', 'Oana_Bogdan@yahoo.com', '+40 791 210 345', TO_DATE('29-02-2020', 'dd-mm-yyyy'), 'Laborant experimentator', 9000);
INSERT INTO Angajat values(14, 2, 2, 'Ene', 'George', 'George_Ene@outlook.com', '+40 738 210 345', TO_DATE('22-11-2021', 'dd-mm-yyyy'), 'Inginer textile', 12000);
INSERT INTO Angajat values(15, 2, 2, 'Mitrea', 'Diana', 'Diana_Mitrea@gmail.com', '+40 792 210 345', TO_DATE('04-10-2018', 'dd-mm-yyyy'), 'Designer textile', 9000);
INSERT INTO Angajat values(16, 2, 2, 'Toma', 'Adrian', 'Adrian_Toma@yahoo.com', '+40 739 210 345', TO_DATE('18-10-2022', 'dd-mm-yyyy'), 'Operator Utilaje', 7000);
INSERT INTO Angajat values(17, 2, 2, 'Ciucu', 'Ema', 'Ema_Ciucu@outlook.com', '+40 793 210 345', TO_DATE('27-08-2021', 'dd-mm-yyyy'), 'Croitor', 8000);
INSERT INTO Angajat values(18, 4, 4, 'Dumitrache', 'Iulian', 'Iulian_Dumitrache@gmail.com', '+40 790 210 345', TO_DATE('25-10-2020', 'dd-mm-yyyy'), 'Inginer textile', 12000);
INSERT INTO Angajat values(19, 4, 4, 'Dan', 'Daniel', 'Daniel_Dan@yahoo.com', '+40 799 210 345', TO_DATE('11-08-2018', 'dd-mm-yyyy'), 'Designer accesorii', 6500);
INSERT INTO Angajat values(20, 4, 4, 'Dumitrache', 'Florin', 'Florin_Dumitrache@outlook.com', '+40 729 123 456', TO_DATE('29-01-2021', 'dd-mm-yyyy'), 'Operator Utilaje', 7000);
INSERT INTO Angajat values(21, 4, 4, 'Popescu', 'Andreea', 'Andreea_Popescu@gmail.com', '+40 721 345 678', TO_DATE('06-01-2020', 'dd-mm-yyyy'), 'Croitor', 8000);
INSERT INTO Angajat values(22, 5, 5, 'Ionescu', 'Alex', 'Alex_Ionescu@yahoo.com', '+40 754 321 678', TO_DATE('20-06-2019', 'dd-mm-yyyy'), 'Muncitor', 5000);
INSERT INTO Angajat values(23, 5, 5, 'Matei', 'Ioana', 'Ioana_Matei@outlook.com', '+40 762 543 210', TO_DATE('14-11-2021', 'dd-mm-yyyy'), 'Agent de livrari', 4500);
INSERT INTO Angajat values(24, 5, 5, 'Gheorghe', 'Roxana', 'Roxana_Gheorghe@gmail.com', '+40 732 145 678', TO_DATE('03-06-2018', 'dd-mm-yyyy'), 'Agent de livrari', 4500);
INSERT INTO Angajat values(25, 5, 5, 'Vasile', 'Cristian', 'Cristian_Vasile@yahoo.com', '+40 786 210 345', TO_DATE('25-01-2019', 'dd-mm-yyyy'), 'Muncitor', 5000);
INSERT INTO Angajat values(26, 2, 2, 'Bogdan', 'Ana', 'Ana_Bogdan@outlook.com', '+40 756 432 210', TO_DATE('28-03-2020', 'dd-mm-yyyy'), 'Operator Utilaje', 7000);
INSERT INTO Angajat values(27, 1, 1, 'Ene', 'Mihai', 'Mihai_Ene@gmail.com', '+40 723 210 345', TO_DATE('30-07-2021', 'dd-mm-yyyy'), 'Operator Utilaje', 7000);
INSERT INTO Angajat values(28, 4, 4, 'Toma', 'Diana', 'Diana_Toma@yahoo.com', '+40 771 345 678', TO_DATE('14-09-2018', 'dd-mm-yyyy'), 'Operator Utilaje', 7000);
INSERT INTO Angajat values(29, 3, 3, 'Ciucu', 'Mirela', 'Mirela_Ciucu@outlook.com', '+40 781 210 345', TO_DATE('05-09-2019', 'dd-mm-yyyy'), 'Inginer chimist', 13000);

---INSERT UTILAJ
INSERT INTO Utilaj values(0, 1, 'Masina de cusut', 'Juki DDL-9000B');
INSERT INTO Utilaj values(1, 1, 'Cutter', 'Eastman T480X');
INSERT INTO Utilaj values(2, 1, 'Masina de taiat etichete', 'Reliable 5000M');
INSERT INTO Utilaj values(3, 1, 'Masina de ambalat', 'Kite Packaging TP-350');

INSERT INTO Utilaj values(4, 2, 'Masina de cusut', 'Juki DDL-9000B');
INSERT INTO Utilaj values(5, 2, 'Cutter', 'Eastman T480X');
INSERT INTO Utilaj values(6, 2, 'Masina de taiat etichete', 'Reliable 5000M');
INSERT INTO Utilaj values(7, 2, 'Masina de ambalat', 'Kite Packaging TP-350');

INSERT INTO Utilaj values(8, 4, 'Masina de cusut', 'Juki DDL-9000B');
INSERT INTO Utilaj values(9, 4, 'Cutter', 'Eastman T480X');
INSERT INTO Utilaj values(10, 4, 'Masina de taiat etichete', 'Reliable 5000M');
INSERT INTO Utilaj values(11, 4, 'Masina de ambalat', 'Kite Packaging TP-350');

INSERT INTO Utilaj values(12, 3, 'Densitometru', 'Hach HI 93703');
INSERT INTO Utilaj values(13, 3, 'pH-metre', 'Hach HI 8424');
INSERT INTO Utilaj values(14, 3, 'Cantar de precizie', 'Mettler XPE1202');
INSERT INTO Utilaj values(15, 3, 'Pipeta', 'Eppendorf Reference 2');
INSERT INTO Utilaj values(16, 3, 'Agitator magnetic', 'IKA C-MAG');

INSERT INTO Utilaj values(17, 5, 'Stivuitor', 'EFL181');
INSERT INTO Utilaj values(18, 5, 'Transpalet', 'CDD12-A2MJ-SZ');

---INSERT OBIECTE

INSERT INTO Obiect values(0, 0, 'Combinezon impermeabil de unica folosinta');
INSERT INTO Obiect values(1, 0, 'Combinezon categoria III');
INSERT INTO Obiect values(2, 0, 'Combinezon cu banda albastra');
INSERT INTO Obiect values(3, 1, 'Costum anticaloric aluminizat');
INSERT INTO Obiect values(4, 1, 'Manusi de protectie la temperaturi inalte');
INSERT INTO Obiect values(5, 1, 'Costum semiuscat scufundari');
INSERT INTO Obiect values(6, 1, 'Costum uscat scufundari');

---INSERT FURNIZORI
INSERT INTO Furnizor values(0, 'Politext'); --- Poliester
INSERT INTO Furnizor values(1, 'Adra Group'); --- Polipropilena laminata
INSERT INTO Furnizor values(2, 'Popescu Conf'); --- Polietilena
INSERT INTO Furnizor values(3, 'NeoTextiles'); --- Neopren
INSERT INTO Furnizor values(4, 'Firesist'); --- Fibra poliacrilonitrilica termooxidata ignifuga
INSERT INTO Furnizor values(5, 'Elastik'); --- Elastic
INSERT INTO Furnizor values(6, 'Zips Conf'); --- Fermoare
INSERT INTO Furnizor values(7, 'AluText'); --- Fibra aramidica aluminizata

---INSERT CLIENTI
INSERT INTO Client values(0, 0, 'MediCare'); ---Combinezon impermeabil de unica folosinta
INSERT INTO Client values(1, 1, 'UrgentCare'); ---Combinezon categoria III
INSERT INTO Client values(2, 3, 'BioCare'); ---Costum anticaloric aluminizat
INSERT INTO Client values(3, 4, 'ForgeShop'); ---Manusi de protectie la temperaturi inalte
INSERT INTO Client values(4, 6, 'Scuba Vacations'); ---Costum uscat scufundari

---INSERT MATERIAL_NECESAR
INSERT INTO Material_Necesar values(0, 'S', 0, 5300);
INSERT INTO Material_Necesar values(0, 'M', 0, 6000);
INSERT INTO Material_Necesar values(0, 'L', 0, 6700);

INSERT INTO Material_Necesar values(1, 'S', 1, 5300);
INSERT INTO Material_Necesar values(1, 'M', 1, 6000);
INSERT INTO Material_Necesar values(1, 'L', 1, 6700);

INSERT INTO Material_Necesar values(2, 'S', 1, 2650);
INSERT INTO Material_Necesar values(2, 'M', 1, 3000);
INSERT INTO Material_Necesar values(2, 'L', 1, 3350);

INSERT INTO Material_Necesar values(2, 'S', 2, 2650);
INSERT INTO Material_Necesar values(2, 'M', 2, 3000);
INSERT INTO Material_Necesar values(2, 'L', 2, 3350);

INSERT INTO Material_Necesar values(3, 'S', 7, 5300);
INSERT INTO Material_Necesar values(3, 'M', 7, 6000);
INSERT INTO Material_Necesar values(3, 'L', 7, 6700);

INSERT INTO Material_Necesar values(4, 'S', 4, 360);
INSERT INTO Material_Necesar values(4, 'M', 4, 430);
INSERT INTO Material_Necesar values(4, 'L', 4, 500);

INSERT INTO Material_Necesar values(5, 'S', 3, 4800);
INSERT INTO Material_Necesar values(5, 'M', 3, 5420);
INSERT INTO Material_Necesar values(5, 'L', 3, 6097);

INSERT INTO Material_Necesar values(6, 'S', 3, 4800);
INSERT INTO Material_Necesar values(6, 'M', 3, 5420);
INSERT INTO Material_Necesar values(6, 'L', 3, 6097);

INSERT INTO Material_Necesar values(0, 'S', 6, 1);
INSERT INTO Material_Necesar values(1, 'S', 6, 1);
INSERT INTO Material_Necesar values(2, 'S', 6, 1);
INSERT INTO Material_Necesar values(3, 'S', 6, 1);
INSERT INTO Material_Necesar values(4, 'S', 6, 1);
INSERT INTO Material_Necesar values(5, 'S', 6, 1);
INSERT INTO Material_Necesar values(6, 'S', 6, 1);

INSERT INTO Material_Necesar values(0, 'M', 6, 1);
INSERT INTO Material_Necesar values(1, 'M', 6, 1);
INSERT INTO Material_Necesar values(2, 'M', 6, 1);
INSERT INTO Material_Necesar values(3, 'M', 6, 1);
INSERT INTO Material_Necesar values(4, 'M', 6, 1);
INSERT INTO Material_Necesar values(5, 'M', 6, 1);
INSERT INTO Material_Necesar values(6, 'M', 6, 1);

INSERT INTO Material_Necesar values(0, 'L', 6, 1);
INSERT INTO Material_Necesar values(1, 'L', 6, 1);
INSERT INTO Material_Necesar values(2, 'L', 6, 1);
INSERT INTO Material_Necesar values(3, 'L', 6, 1);
INSERT INTO Material_Necesar values(4, 'L', 6, 1);
INSERT INTO Material_Necesar values(5, 'L', 6, 1);
INSERT INTO Material_Necesar values(6, 'L', 6, 1);

INSERT INTO Material_Necesar values(0, 'S', 5, 1);
INSERT INTO Material_Necesar values(1, 'S', 5, 1);
INSERT INTO Material_Necesar values(2, 'S', 5, 1);
INSERT INTO Material_Necesar values(3, 'S', 5, 1);
INSERT INTO Material_Necesar values(4, 'S', 5, 1);
INSERT INTO Material_Necesar values(5, 'S', 5, 1);
INSERT INTO Material_Necesar values(6, 'S', 5, 1);

INSERT INTO Material_Necesar values(0, 'M', 5, 1);
INSERT INTO Material_Necesar values(1, 'M', 5, 1);
INSERT INTO Material_Necesar values(2, 'M', 5, 1);
INSERT INTO Material_Necesar values(3, 'M', 5, 1);
INSERT INTO Material_Necesar values(4, 'M', 5, 1);
INSERT INTO Material_Necesar values(5, 'M', 5, 1);
INSERT INTO Material_Necesar values(6, 'M', 5, 1);

INSERT INTO Material_Necesar values(0, 'L', 5, 1);
INSERT INTO Material_Necesar values(1, 'L', 5, 1);
INSERT INTO Material_Necesar values(2, 'L', 5, 1);
INSERT INTO Material_Necesar values(3, 'L', 5, 1);
INSERT INTO Material_Necesar values(4, 'L', 5, 1);
INSERT INTO Material_Necesar values(5, 'L', 5, 1);
INSERT INTO Material_Necesar values(6, 'L', 5, 1);

--delete from material_necesar;

---INSERT COMENZI
INSERT INTO Comanda values(0, 1, 1, 'M', 20);
INSERT INTO Comanda values(1, 1, 1, 'L', 17);
INSERT INTO Comanda values(2, 4, 6, 'S', 7);

---INSERT ISTORIC_ANGAJARI
INSERT INTO Istoric_Angajari values(0, 1, 1, 'Inginer Textile', TO_DATE('19-07-2016', 'dd-mm-yyyy'), TO_DATE('15-09-2020', 'dd-mm-yyyy'));
INSERT INTO Istoric_Angajari values(2, 2, 2, 'Manager', TO_DATE('25-11-2022', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(3, 3, 3, 'Manager', TO_DATE('10-09-2018', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(4, 4, 4, 'Manager', TO_DATE('16-12-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(5, 5, 5, 'Manager', TO_DATE('18-05-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(6, 6, 0, 'Secretar', TO_DATE('15-02-2019', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(7, 7, 0, 'Director Relatii cu Clientii', TO_DATE('12-01-2020', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(8, 8, 1, 'Inginer textile', TO_DATE('14-08-2020', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(9, 9, 1, 'Designer textile', TO_DATE('04-06-2022', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(10, 10, 1, 'Operator Utilaje', TO_DATE('19-04-2018', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(11, 11, 1, 'Croitor', TO_DATE('20-10-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(12, 12, 3, 'Inginer chimist', TO_DATE('31-08-2022', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(13, 13, 3, 'Laborant experimentator', TO_DATE('29-02-2020', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(14, 14, 2, 'Inginer textile', TO_DATE('22-11-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(15, 15, 2, 'Designer textile', TO_DATE('04-10-2018', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(16, 16, 2, 'Operator Utilaje', TO_DATE('18-10-2022', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(17, 17, 2, 'Croitor', TO_DATE('27-08-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(18, 18, 4, 'Inginer textile', TO_DATE('25-10-2020', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(19, 19, 4, 'Designer accesorii', TO_DATE('11-08-2018', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(20, 20, 4, 'Operator Utilaje', TO_DATE('29-01-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(21, 21, 4, 'Croitor', TO_DATE('06-01-2020', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(22, 22, 5, 'Muncitor', TO_DATE('20-06-2019', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(23, 23, 5, 'Agent de livrari', TO_DATE('14-11-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(24, 24, 5, 'Agent de livrari', TO_DATE('03-06-2018', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(25, 25, 5, 'Muncitor', TO_DATE('25-01-2019', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(26, 26, 2, 'Operator Utilaje', TO_DATE('28-03-2020', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(27, 27, 1, 'Operator Utilaje', TO_DATE('30-07-2021', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(28, 28, 4, 'Operator Utilaje', TO_DATE('14-09-2018', 'dd-mm-yyyy'), null);
INSERT INTO Istoric_Angajari values(29, 29, 3, 'Inginer chimist', TO_DATE('05-09-2019', 'dd-mm-yyyy'), null);


commit;

---CREARE VIEW COMPUS
CREATE OR REPLACE VIEW Compus1 as
(
    SELECT *
    FROM angajat
    WHERE id_departament >= 3
);

CREATE OR REPLACE VIEW Compus2 as
(
    SELECT *
    FROM departament
    WHERE lower(nume_departament) like '%inginer%'
);

---CREARE VIEW COMPLEX
CREATE OR REPLACE VIEW Complex as
(
    SELECT id_angajat, id_departament, titlu_job
    FROM Compus1 join Compus2 using(id_departament)
);

---QUERY SELECT PENTRU SUBIECTUL III
--SELECT *
--FROM Locatie join Departament using(id_locatie) join Angajat using(id_departament)
--WHERE lower(locatie.tip) like 'fabrica' and angajat.data_angajare >= TO_DATE('01-01-2021', 'dd-mm-yyyy');

--SELECT id_departament, avg(salariu)
--FROM angajat
--GROUP BY id_departament
HAVING COUNT(id_angajat) > 3;