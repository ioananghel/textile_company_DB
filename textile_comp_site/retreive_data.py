import cx_Oracle
import pandas as pd

cx_Oracle.init_oracle_client(lib_dir=r"C:\Users\xelar\Downloads\instantclient-basic-windows.x64-21.8.0.0.0dbru\instantclient_21_8")

# conStr = 'ioantudoranghel/ioantudor#16@193.226.51.37:1521/o11g'\
conStr = 'system/parola@localhost:1522/xe'

conn = cx_Oracle.connect(conStr)
cur = conn.cursor()

def All_Locatie():
    sqlTxt = 'SELECT * FROM Locatie'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Locatie_ASC():
    sqlTxt = 'SELECT * FROM Locatie ORDER BY strada'
    cur.execute(sqlTxt)

    records = cur.fetchall()
    
    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Departament():
    sqlTxt = 'SELECT * FROM Departament'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Departament_ASC():
    sqlTxt = 'SELECT * FROM Departament ORDER BY nume_departament'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Angajat():
    sqlTxt = 'SELECT * FROM Angajat'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Angajat_ASC():
    sqlTxt = 'SELECT * FROM Angajat ORDER BY nume'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Utilaj():
    sqlTxt = 'SELECT * FROM Utilaj'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Utilaj_ASC():
    sqlTxt = 'SELECT * FROM Utilaj ORDER BY nume_utilaj'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Obiect():
    sqlTxt = 'SELECT * FROM Obiect'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Obiect_ASC():
    sqlTxt = 'SELECT * FROM Obiect ORDER BY nume'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Client():
    sqlTxt = 'SELECT * FROM Client'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Client_ASC():
    sqlTxt = 'SELECT * FROM Client ORDER BY nume'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Comanda():
    sqlTxt = 'SELECT * FROM Comanda'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Comanda_ASC():
    sqlTxt = 'SELECT * FROM Comanda ORDER BY nr_bucati'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Furnizor():
    sqlTxt = 'SELECT * FROM Furnizor'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Furnizor_ASC():
    sqlTxt = 'SELECT * FROM Furnizor ORDER BY nume'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Material_Necesar():
    sqlTxt = 'SELECT * FROM Material_Necesar'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def All_Material_Necesar_ASC():
    sqlTxt = 'SELECT * FROM Material_Necesar ORDER BY cantitate_necesara'
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def Custom_query():
    sqlTxt = "SELECT * FROM Locatie join Departament using(id_locatie) join Angajat using(id_departament) WHERE lower(locatie.tip) like 'fabrica' and angajat.data_angajare >= TO_DATE('01-01-2021', 'dd-mm-yyyy')"
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def Custom_Having_query():
    sqlTxt = "SELECT id_departament, avg(salariu) FROM angajat GROUP BY id_departament HAVING COUNT(id_angajat) > 3"
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def Get_Composed_View():
    sqlTxt = "SELECT * FROM Compus1"
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

def Get_Complex_View():
    sqlTxt = "SELECT * FROM Complex"
    cur.execute(sqlTxt)

    records = cur.fetchall()

    df = pd.DataFrame.from_records(records, columns = [x[0] for x in cur.description])
    return df

Locatie = All_Locatie()

LocatieASC = All_Locatie_ASC()

Departament = All_Departament()

DepartamentASC = All_Departament_ASC()

Angajat = All_Angajat()

AngajatASC = All_Angajat_ASC()

Utilaj = All_Utilaj()

UtilajASC = All_Utilaj_ASC()

Obiect = All_Obiect()

ObiectASC = All_Obiect_ASC()

Client = All_Client()

Client_ASC = All_Client_ASC()

Comanda = All_Comanda()

ComandaASC = All_Comanda_ASC()

Furnizor = All_Furnizor()

FurnizorASC = All_Furnizor_ASC()

Material_Necesar = All_Material_Necesar()

Material_NecesarASC = All_Material_Necesar_ASC()

Custom = Custom_query()

Custom_having = Custom_Having_query()

View_compus = Get_Composed_View()

View_complex = Get_Complex_View()

import cgi

def user_query(sqlTxt):
    
    cur.execute(sqlTxt)
    conn.commit()

query = cgi.FieldStorage()
txt = query.getvalue('query')
user_query(txt)


#print(Locatie, LocatieASC, Departament, DepartamentASC, Angajat, AngajatASC, Utilaj, UtilajASC, Obiect, ObiectASC, Client, Client_ASC, Comanda, ComandaASC, Furnizor, FurnizorASC, Material_Necesar, Material_NecesarASC)


# conn.commit()

cur.close()
conn.close()