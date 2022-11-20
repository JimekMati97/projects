# Django Social App
> Django social application allows you to create accounts, publish your own posts, comment and like posts from your contacts.
In addition, it is an intermediary tool in text communication in the 1 to 1 person conversation model 
model.

## Table of Contents
* [Instalation](#instalation)
* [Technologies Used](#technologies-used)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Contact](#contact)

## Instalation
Clone to your local file system, folder from projects repozitory, called django_socilapp. 
In a your local folder, create virtual environment, for example:
```
python -m virtualenv .
```
next activate it:
```
.\Scripts\activate
```
Now, create src folder and change directory, for one where you would like to install django:
```
mkdir src
cd src
pip django install
```
After installing django, you can copy whole project (comments), app (coApp), static, templates, db.sqlite3 and manage.py to src folder.
Before you start django server, you need to install a Pillow module:
```
python -m pip install Pillow
```
Next run server:
```
python manage.py runserver
```
## Technologies Used
- Python 3.9.13
- Django 4.1.3
- JavaScript ES6
- MySql
- CSS 3
- HTML 5
- Bootstrap 4
- Ajax 


## Project Status
_in_production_

## Room for Improvement

- Currently, the conversation management system uses ajax to communicate with the database. 
This is a pre-production solution that should be built using websockets - django channels to 
improve system performance.
- Increasing user-friendly application solutions based on front end restructuring
- Scalability of profile images
- Possibility to edit or delete posts

## Contact
Created by Mateusz Paździo - feel free to contact me!
- matipazdzio@interia.pl
- https://www.linkedin.com/in/mateusz-pa%C5%BAdzio-b360971b3/
