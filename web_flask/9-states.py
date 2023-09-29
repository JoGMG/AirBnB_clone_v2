#!/usr/bin/python3
""" A script that starts a Flask web application """
from flask import Flask, render_template
from models import storage
from models.state import State

app = Flask(__name__)
app.url_map.strict_slashes = False


@app.route('/states')
def states():
    all_states = list(storage.all(State).values())
    all_states.sort(key=lambda x: x.name)
    states_list = {'states': all_states}
    return render_template('9-states.html', **states_list)


@app.route('/states/<id>')
def states_id(id):
    all_states = list(storage.all(State).values())
    all_states.sort(key=lambda x: x.name)
    states_list = {'states': all_states}
    for state in states_list.values():
        if state.id == id:
            return render_template('9-states.html', **states_list)
    return render_template('9-states.html')


@app.teardown_appcontext
def teardown(exc):
    """ Remove the current SQLAlchemy session """
    storage.close()


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
