#!/usr/bin/python3
""" A script that starts a Flask web application """
from flask import Flask, render_template

app = Flask(__name__)


@app.route('/', strict_slashes=False)
def hello():
    return 'Hello HBNB!'


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    return 'HBNB!'


@app.route('/c/<text>', strict_slashes=False)
def c_index(text):
    return 'C {}'.format(text.replace('_', ' '))


@app.route('/python/<text>', strict_slashes=False)
@app.route('/python', defaults={'text': 'is cool'}, strict_slashes=False)
def python_index(text):
    return 'Python {}'.format(text.replace('_', ' '))


@app.route('/number/<n>', strict_slashes=False)
def num_index(n):
    if type(n) == int or float:
        return '{} is a number'.format(n)


@app.route('/number_template/<n>', strict_slashes=False)
def num_template(n):
    if type(n) == int or float:
        num = {
            'n': n
        }
        return render_template('5-number.html', **num)


@app.route('/number_odd_or_even/<n>', strict_slashes=False)
def num_odd_even(n):
    if type(n) == int or float:
        num = {
            'n': n
        }
        return render_template('6-number_odd_or_even.html', **num)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)