from flask import Blueprint, render_template, request, flash, redirect, url_for
from .models import User
from werkzeug.security import generate_password_hash, check_password_hash
from . import db
from flask_login import login_user, login_required, logout_user, current_user
import retreive_data


auth = Blueprint('auth', __name__)

@auth.route('/locatii', methods=['GET'])
def locatii():
    return render_template("locatii.html", user = current_user, datafr = retreive_data.Locatie)

@auth.route('/locatiiASC', methods=['GET'])
def locatiiASC():
    return render_template("locatiiASC.html", user = current_user, datafr = retreive_data.LocatieASC)

@auth.route('/departamente', methods=['GET'])
def departamente():
    return render_template("departamente.html", user = current_user, datafr = retreive_data.Departament)

@auth.route('/departamenteASC', methods=['GET'])
def departamenteASC():
    return render_template("departamenteASC.html", user = current_user, datafr = retreive_data.DepartamentASC)

@auth.route('/angajati', methods=['GET'])
def angajati():
    return render_template("angajati.html", user = current_user, datafr = retreive_data.Angajat)

@auth.route('/angajatiASC', methods=['GET'])
def angajatiASC():
    return render_template("angajatiASC.html", user = current_user, datafr = retreive_data.AngajatASC)

@auth.route('/utilaje', methods=['GET'])
def utilaje():
    return render_template("utilaje.html", user = current_user, datafr = retreive_data.Utilaj)

@auth.route('/utilajeASC', methods=['GET'])
def utilajeASC():
    return render_template("utilajeASC.html", user = current_user, datafr = retreive_data.UtilajASC)

@auth.route('/obiecte', methods=['GET'])
def obiecte():
    return render_template("obiecte.html", user = current_user, datafr = retreive_data.Obiect)

@auth.route('/obiecteASC', methods=['GET'])
def obiecteASC():
    return render_template("obiecteASC.html", user = current_user, datafr = retreive_data.ObiectASC)

@auth.route('/clienti', methods=['GET'])
def clienti():
    return render_template("clienti.html", user = current_user, datafr = retreive_data.Client)

@auth.route('/clientiASC', methods=['GET'])
def clientiASC():
    return render_template("clientiASC.html", user = current_user, datafr = retreive_data.Client_ASC)

@auth.route('/furnizori', methods=['GET'])
def furnizori():
    return render_template("furnizori.html", user = current_user, datafr = retreive_data.Furnizor)

@auth.route('/furnizoriASC', methods=['GET'])
def furnizoriASC():
    return render_template("furnizoriASC.html", user = current_user, datafr = retreive_data.FurnizorASC)

@auth.route('/comenzi', methods=['GET'])
def comenzi():
    return render_template("comenzi.html", user = current_user, datafr = retreive_data.Comanda)

@auth.route('/comenziASC', methods=['GET'])
def comenziASC():
    return render_template("comenziASC.html", user = current_user, datafr = retreive_data.ComandaASC)

@auth.route('/materiale', methods=['GET'])
def materiale():
    return render_template("materiale.html", user = current_user, datafr = retreive_data.Material_Necesar)

@auth.route('/materialeASC', methods=['GET'])
def materialeASC():
    return render_template("materialeASC.html", user = current_user, datafr = retreive_data.Material_NecesarASC)

@auth.route('/custom', methods=['GET'])
def custom():
    return render_template("custom.html", user = current_user, datafr = retreive_data.Custom)

@auth.route('/custom_having', methods=['GET'])
def custom_having():
    return render_template("custom_having.html", user = current_user, datafr = retreive_data.Custom_having)

@auth.route('/composed_view', methods=['GET'])
def composed_view():
    return render_template("composed_view.html", user = current_user, datafr = retreive_data.View_compus)

@auth.route('/complex_view', methods=['GET'])
def complex_view():
    return render_template("complex_view.html", user = current_user, datafr = retreive_data.View_complex)