# Hbnb - The Console

This repository contains the initial segment of a project to build a clone of the AirBnB website. This stage implements a back-end interface to manage program data. The goal is to eventually deploy our server containing a simple copy of the AirBnB website (Hbnb). A console (command interpreter) is created to manage data objects for Hbnb.

---

## The Command Interpreter

The command interpreter (console) provides simple commands to manage data. You can find some examples of its usage [here](#examples).

### How To Use

1. First clone this repository.

2. Once the repository is cloned locate the "[console.py](console.py)" file and run it as follows:
   ```
   ➜ ./console.py or python console.py
   ```

4. When this command is run the following prompt should appear:
   ```
   (hbnb)
   ```

5. This prompt designates that you are in the "Hbnb" console. There are a variety of commands available within the console program.

### Supported Commands

The command interpreter (console) supports two basic command syntaxes:<br>
- Primary/Main Command Syntax
   - `command [argument]...`
- Alternative Command Syntax
   - `Model.command([argument]...)`
   - with the exception of the commands (`help`, `quit`, `EOF` and `create`)

| Syntax | Description |
|:-|:-|
| `help [command]` | Prints helpful information about a command. If `command` is not provided, it prints the help menu. |
| `quit` | Closes the command interpreter. |
| `EOF` | Closes the command interpreter. |
| `create Model [param_name="param_value"]...` | Creates a new instance of the `Model` class with the given parameters. `param_value` can be a double or single quoted string with escaped double or single quotes and underscores replaced with spaces. It can also be a float or integer without quotes. |
| `count Model` | Prints the number of instances of the `Model` class. |
| `show Model id` | Prints the string representation of an instance of the `Model` class with the given `id`. |
| `destroy Model id` | Deletes an instance of the `Model` class with the given `id`. |
| `all [Model]` | Prints a list containing the string representation of all instances of the `Model` class. `Model` is optional and if it isn't provided, all the availble objects are printed. |
| `update Model id param_name param_value` | Updates an instance of the `Model` class with the given `id` by assigning the `param_value` to its `param_name`. Parameters such as `__class__`, `id`, `created_at`, and `updated_at` are silently ignored. |
| `update Model id dict_param` | Updates an instance of `Model` having the given `id` by storing the key, value pairs in the given `dict_param` dictionary as its parameters. The parameters `__class__`, `id`, `created_at`, and `updated_at` are silently ignored. |
<br>

### Supported Models

These are the models that are currently available.

| Class | Description |
|:-|:-|
| BaseModel | An (abstract) class that represents the base class for all models (all models below inherit the properties of this class). |
| User | Represents a user account. |<br>
| State | Represents the state in which a _User_ lives or a _City_ belongs to. |
| City | Represents an urban area in a _State_. |
| Place | Represents a place of accomodation in a _City_ that can be rented by a _User_. |
| Amenity | Represents a feature of a _Place_. |
| Review | Represents a review of a _Place_. |

### Environment Variables

+ `HBNB_ENV`: The running environment. It can be `dev` or `test`.
+ `HBNB_MYSQL_USER`: The MySQL server username.
+ `HBNB_MYSQL_PWD`: The MySQL server password.
+ `HBNB_MYSQL_HOST`: The MySQL server hostname.
+ `HBNB_MYSQL_DB`: The MySQL server database name.
+ `HBNB_TYPE_STORAGE`: The type of storage used. It can be `fs` (using `FileStorage`) or `db` (using `DBStorage`).

### Examples

<h3>Primary Command Syntax</h3>

###### Example 0: Create an instance (with or without parameters)
Usage: create `<class_name>`<br>OR<br>create `<class_name> <param_name>="<param_value>"`
```
(hbnb) create BaseModel
2f135e8c-a773-4b36-9c5f-708e125b3e71
(hbnb)
```
```
(hbnb) create BaseModel name="John"
8b34cf2a-ab26-4a1f-a319-e28c9355220d
(hbnb)
```

###### Example 1: Show an instance
Usage: show <class_name> <\id>
```
(hbnb) show BaseModel 2f135e8c-a773-4b36-9c5f-708e125b3e71
[BaseModel] (2f135e8c-a773-4b36-9c5f-708e125b3e71) {'id': '2f135e8c-a773-4b36-9c5f-708e125b3e71', 'created_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966289), 'updated_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966307)}
(hbnb)
```
```
(hbnb) show BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d
[BaseModel] (8b34cf2a-ab26-4a1f-a319-e28c9355220d) {'id': '8b34cf2a-ab26-4a1f-a319-e28c9355220d', 'created_at': datetime.datetime(2023, 10, 4, 2, 16, 44, 7206), 'updated_at': datetime.datetime(2023, 10, 4, 2, 16, 44, 7229), 'name': 'John'}
```

###### Example 2: Update an instance
Usage: update <class_name> <\id> <param_name> <param_value><br>OR<br>update <class_name> <\id> <dict_param>
```
(hbnb) update BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d name santa
(hbnb) show BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d
[BaseModel] (8b34cf2a-ab26-4a1f-a319-e28c9355220d) {'id': '8b34cf2a-ab26-4a1f-a319-e28c9355220d', 'created_at': datetime.datetime(2023, 10, 4, 2, 16, 44, 7206), 'updated_at': datetime.datetime(2023, 10, 4, 2, 20, 19, 775), 'name': 'santa'}
(hbnb)
```
```
(hbnb) update BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d {'name': 'buddy'}
(hbnb) show BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d
[BaseModel] (8b34cf2a-ab26-4a1f-a319-e28c9355220d) {'id': '8b34cf2a-ab26-4a1f-a319-e28c9355220d', 'created_at': datetime.datetime(2023, 10, 4, 2, 16, 44, 7206), 'updated_at': datetime.datetime(2023, 10, 4, 2, 20, 19, 775), 'name': 'buddy'}
(hbnb)
```

###### Example 3: Destroy an instance
Usage: destroy <class_name> <\id>
```
(hbnb) destroy BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d
(hbnb) show BaseModel 8b34cf2a-ab26-4a1f-a319-e28c9355220d
** no instance found **
(hbnb)
```

###### Example 4: Count an instance
Usage: count <class_name>
```
(hbnb) count BaseModel
1
(hbnb)
```

###### Example 5: Show all instances or all objects of a particular instance
Usage: all<br>OR<br>all <class_name>
```
(hbnb) all
["[BaseModel] (2f135e8c-a773-4b36-9c5f-708e125b3e71) {'id': '2f135e8c-a773-4b36-9c5f-708e125b3e71', 'created_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966289), 'updated_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966307)}"]
(hbnb)
```
```
(hbnb) all BaseModel
["[BaseModel] (2f135e8c-a773-4b36-9c5f-708e125b3e71) {'id': '2f135e8c-a773-4b36-9c5f-708e125b3e71', 'created_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966289), 'updated_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966307)}"]
(hbnb)
```

<h3>Alternative Syntax</h3>

###### Example 0: Show an instance
Usage: <class_name>.show(<\id>)
```
(hbnb) BaseModel.show(2f135e8c-a773-4b36-9c5f-708e125b3e71)
[BaseModel] (2f135e8c-a773-4b36-9c5f-708e125b3e71) {'id': '2f135e8c-a773-4b36-9c5f-708e125b3e71', 'created_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966289), 'updated_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966307)}
(hbnb)
```

###### Example 1: Update an instance
Usage: <class_name>.update(<\id>, <param_name>, <param_value>)<br>OR<br><class_name>.update(<\id>, <dict_param>)
```
(hbnb) BaseModel.update(2f135e8c-a773-4b36-9c5f-708e125b3e71, name, daniel)
(hbnb) BaseModel.show(2f135e8c-a773-4b36-9c5f-708e125b3e71)
[BaseModel] (2f135e8c-a773-4b36-9c5f-708e125b3e71) {'id': '2f135e8c-a773-4b36-9c5f-708e125b3e71', 'created_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966289), 'updated_at': datetime.datetime(2023, 10, 4, 2, 46, 38, 477036), 'name': 'daniel'}
(hbnb)
```
```
(hbnb) BaseModel.update(2f135e8c-a773-4b36-9c5f-708e125b3e71, {'name', 'landon'})
(hbnb) BaseModel.show(2f135e8c-a773-4b36-9c5f-708e125b3e71)
[BaseModel] (2f135e8c-a773-4b36-9c5f-708e125b3e71) {'id': '2f135e8c-a773-4b36-9c5f-708e125b3e71', 'created_at': datetime.datetime(2023, 10, 4, 2, 15, 43, 966289), 'updated_at': datetime.datetime(2023, 10, 4, 2, 46, 38, 477036), 'name': 'landon'}
(hbnb)
```

###### Example 2: Count an instance
Usage: <class_name>.count(<\id>)
```
(hbnb) BaseModel.count(2f135e8c-a773-4b36-9c5f-708e125b3e71)
1
(hbnb)
```

###### Example 3: Destroy an instance
Usage: <class_name>.destroy(<id>)
```
(hbnb) BaseModel.destroy(2f135e8c-a773-4b36-9c5f-708e125b3e71)
(hbnb) BaseModel.show(2f135e8c-a773-4b36-9c5f-708e125b3e71)
** no instance found **
(hbnb)
```

###### Example 4: Show all instances or all objects of a particular instance
Usage: .all()<br>OR<br><class_name>.all()
```
(hbnb) .all()
** no instance found **
(hbnb)
```
```
(hbnb) BaseModel.all()
** no instance found **
(hbnb)
```
<br>

<!-- ## Testing -->

**NOTE:** Before pushing any commit, please make sure to run `python3 -m unittest discover tests` to ensure that no tests are failing and your code complies with this project's styling standard.
