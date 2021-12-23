from itertools import groupby
import json     # noqa: F401
import os

from flask import Flask, render_template, request, redirect, Response    # noqa: F401
import sqlalchemy    # noqa: F401

from models import create_connection, init_db
from packages import register_package_creator, register_models
from config import CONFIGS

if os.environ.get("DATABASE_URL"):
    config = CONFIGS[os.environ.get("ENV", "PROD")]
else:
    config = CONFIGS[os.environ.get("ENV", "DEV")]

app = Flask(__name__,
            static_url_path='/static',
            template_folder='templates')
app.config['WTF_CSRF_ENABLED'] = False # Sensitive



def set_db(config):
    Base, db_session, engine = create_connection(config)
    Package, InstallMethod = register_models(Base)
    init_db(Base, engine)
    return Base, db_session, Package, InstallMethod

@app.teardown_appcontext
def shutdown_session(exception=None):
    db_session.remove()


@app.route("/.well-known/acme-challenge/2KNoLJFbdqcKw-kp7AdoMz7NIBMjphtVCCzvzWqXo9A")
@app.route("/.well-known/acme-challenge/2KNoLJFbdqcKw-kp7AdoMz7NIBMjphtVCCzvzWqXo9A:")
@app.route("/.well-known/acme-challenge/X5V7XUy6JIUkct_Z2-FpZMzi17kxCxM2UK1YXmr02xE")
@app.route("/.well-known/acme-challenge/X5V7XUy6JIUkct_Z2-FpZMzi17kxCxM2UK1YXmr02xE:")
def ahh():
    return "X5V7XUy6JIUkct_Z2-FpZMzi17kxCxM2UK1YXmr02xE.VSiiJ9vHj6AiQauI5ejezPFXlOrJl1sdqak6A0_ol7Q"


@app.route('/')
@app.route('/index')
def index():
    cont = True
    while cont:
        try:
            packages = Package.query.all()
            cont = False
        except:# noqa: E722
            db_session.rollback()
            cont = True

    packages.sort(key=lambda p: p.category)
    packages = groupby(packages, lambda p: p.category)
    ua = request.headers.get('User-Agent')
    linux_ua = True
    if 'Linux' not in ua or 'X11' not in ua:
        linux_ua = False
    return render_template('index.html', packages=packages, linux_ua=linux_ua)


@app.route('/support')
def support():
    return redirect("https://docs.flowalex.tech")

@app.route('/misc')
def misc():
    return render_template("misc.html")

Base, db_session, Package, InstallMethod = set_db(config)
register_package_creator(app,
                         db_session,
                         Package, InstallMethod,
                         template_path="packages/templates")


@app.errorhandler(400)
def bad_request(error):
    return render_template("error/400.html"), 400


@app.errorhandler(401)
def not_authorized(error):
    return render_template("error/401.html"), 401


@app.errorhandler(403)
def forbidden(error):
    return render_template("error/403.html"), 403


@app.errorhandler(404)
def not_found(error):
    return render_template("error/404.html"), 404


@app.errorhandler(405)
def method_not_allowed(error):
    return render_template("error/405.html", method=request.method), 405


@app.errorhandler(500)
def internal_server_error(error):
    return render_template("error/500.html"), 500


if __name__ == "__main__":
    app.run(debug=True, port=5000)
