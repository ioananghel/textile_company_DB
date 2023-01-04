import sys
import random
import datetime

original_stdout = sys.stdout
with open('angajati.txt', 'w') as f:
    sys.stdout = f
    
    nume = [   
        ["Ioan", "Pop"],
        ["Mihai", "Ionescu"],
        ["Elena", "Dumitrescu"],
        ["Ioana", "Stefan"],
        ["Alexandru", "Matei"],
        ["Raluca", "Neagu"],
        ["Cristina", "Dobre"],
        ["Catalin", "Ciobanu"],
        ["Andreea", "Stan"],
        ["Irina", "Gheorghe"],
        ["Mirela", "Mirea"],
        ["Marius", "Ivan"],
        ["Bogdan", "Vasile"],
        ["Oana", "Bogdan"],
        ["George", "Ene"],
        ["Diana", "Mitrea"],
        ["Adrian", "Toma"],
        ["Ema", "Ciucu"],
        ["Iulian", "Dumitrache"],
        ["Daniel", "Dan"],
        ["Florin", "Dumitrache"],
        ["Andreea", "Popescu"],
        ["Alex", "Ionescu"],
        ["Ioana", "Matei"],
        ["Roxana", "Gheorghe"],
        ["Cristian", "Vasile"],
        ["Ana", "Bogdan"],
        ["Mihai", "Ene"],
        ["Diana", "Toma"],
        ["Mirela", "Ciucu"],
    ]

    #Reference: INSERT INTO Angajat values(id(number), id_manager,
    #                                        id_departament, nume, prenume,
    #                                        email, nr_telefon, data_angajare,
    #                                        titlu_job, salariu)

    id_angajat = 0
    id_manager = "null"
    departments = [0, 1, 2, 3, 4, 5]

    email = []
    add = ['@gmail.com', '@yahoo.com', '@outlook.com']
    for name in nume:
        first_name, last_name = name
        email.append(first_name + '_' + last_name + add[len(email) % 3])

    nr_telefon = [
        "+40 729 123 456",
        "+40 721 345 678",
        "+40 754 321 678",
        "+40 762 543 210",
        "+40 732 145 678",
        "+40 786 210 345",
        "+40 756 432 210",
        "+40 723 210 345",
        "+40 771 345 678",
        "+40 781 210 345",
        "+40 735 210 345",
        "+40 798 210 345",
        "+40 736 210 345",
        "+40 791 210 345",
        "+40 738 210 345",
        "+40 792 210 345",
        "+40 739 210 345",
        "+40 793 210 345",
        "+40 790 210 345",
        "+40 799 210 345",
        "+40 729 123 456",
        "+40 721 345 678",
        "+40 754 321 678",
        "+40 762 543 210",
        "+40 732 145 678",
        "+40 786 210 345",
        "+40 756 432 210",
        "+40 723 210 345",
        "+40 771 345 678",
        "+40 781 210 345",
    ]

    def random_date():
        current_date = datetime.date.today()
        random_delta = datetime.timedelta(days=random.randint(1, 365 * 5))
        return current_date - random_delta

    data_angajare = [random_date() for _ in range(30)]

    data_angajare = [date.strftime("%d-%m-%Y") for date in data_angajare]

    #de creat titlu_job

    titlu_job = []
    for _ in range(30):
        if _ < 6:
            titlu_job.append('Manager')
        else:
            titlu_job.append('to be replaced')

    # for date in data_angajare:
    #     print(date)


    #Reference: INSERT INTO Angajat values(id(number), id_manager,
    #                                        id_departament, nume, prenume,
    #                                        email, nr_telefon, data_angajare,
    #                                        titlu_job, salariu)

    for _ in range(30):
        first_name, last_name = nume[_]
        email_add = email[_]

        print(f"INSERT INTO Angajat values({id_angajat}, {id_manager}, {departments[len(departments) % 6]}, '{last_name}', '{first_name}', '{email_add}', '{nr_telefon[_]}', TO_DATE('{data_angajare[_]}', 'dd-mm-yyyy'), '{titlu_job[_]}', None)")
        id_angajat += 1


    sys.stdout = original_stdout
