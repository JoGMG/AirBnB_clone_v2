#!/usr/bin/python3
""" A script that starts a Flask web application """
from flask import Flask, render_template
from models import storage
from models.state import State

app = Flask(__name__)
app.url_map.strict_slashes = False


@app.route('/states_list')
def states():
    all_states = list(storage.all(State).values())
    all_states.sort(key=lambda x: x.name)
    states_list = {
        'states': all_states
    }
    return render_template('7-states_list.html', **states_list)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
