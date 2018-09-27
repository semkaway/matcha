from __future__ import division
from flask import Flask, render_template, flash, redirect, url_for, session, logging, request, current_app, jsonify, send_from_directory
from flask_mail import Mail
import mysql.connector
from validators import validate_email, validate_password, confirm_password, send_message
from wtforms import Form, StringField, TextAreaField, PasswordField, IntegerField
from itsdangerous import URLSafeTimedSerializer, SignatureExpired
from passlib.hash import sha256_crypt
from werkzeug.utils import secure_filename
from werkzeug.datastructures import FileStorage
import os
from PIL import Image
from flask_dropzone import Dropzone
from flask_uploads import UploadSet, configure_uploads, IMAGES, patch_request_class
from geopy.geocoders import Nominatim
from functools import wraps
from flask_socketio import SocketIO, send, emit
import shutil
from datetime import date
import math

import time

import sys, errno

# from signal import signal, SIGPIPE, SIG_DFL
# signal(SIGPIPE, SIG_DFL)


# CONFIGURATION

app = Flask(__name__)

app.config.from_pyfile('configuration.cfg')

mail = Mail(app)
dropzone = Dropzone(app)
geolocator = Nominatim(user_agent="matcha")
socketio = SocketIO(app, manage_session=True)

s = URLSafeTimedSerializer(app.config['SECRET_KEY'])

config = {
	'host' : 'localhost',
	'user' : 'test',
	'password' : 'test',
}

mydb = mysql.connector.connect(**config)

ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

def allowed_file(filename):
	return '.' in filename and \
		   filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def crop(image_path, coords, saved_location):
	image_obj = Image.open(image_path)
	cropped_image = image_obj.crop(coords)
	cropped_image.save(saved_location)

def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized. Please, log in', 'danger')
			return redirect(url_for('login'))
	return wrap

def is_logged_out(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' not in session:
			return f(*args, **kwargs)
		else:
			flash('You are already logged in', 'danger')
			return redirect(url_for('edit'))
	return wrap

def get_gender(user_demands):
	target_gender = "Both"
	if user_demands['target_gender'] == "Women":
		target_gender = "Woman"
	elif user_demands['target_gender'] == "Men":
		target_gender = "Man"
	return target_gender

def get_users(sort, sort1, request, my_user_demands):
	cur = mydb.cursor(dictionary=True, buffered=True)

	app.logger.info(my_user_demands)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (session['id'], ))
	user_demands = cur.fetchone()
	cur.execute("SELECT * FROM matcha.users_location WHERE user_id = %s", (session['id'], ))
	locate_user = cur.fetchone()
	if locate_user['user_city'] == 'Unknown':
		user_location = locate_user['city']
	else:
		user_location = locate_user['user_city']
	target_gender = get_gender(user_demands)

	cur.execute("SET sql_mode = ''")
	cur.execute('''SELECT b.user_id AS recommended_user, a.interest_id
					FROM matcha.users_interests a, matcha.users_interests b
					WHERE a.user_id = %s AND b.user_id != %s AND a.interest_id = b.interest_id GROUP BY recommended_user HAVING COUNT(*) >= 1''', (session['id'], session['id'], ))
	interests = cur.fetchall()

	cur.execute('''SELECT b.user_id AS recommended_user, a.interest_id
					FROM matcha.users_interests a, matcha.users_interests b
					WHERE a.user_id = %s AND b.user_id != %s AND a.interest_id = b.interest_id''', (session['id'], session['id'], ))
	my_interests = cur.fetchall()

	cur.execute("SELECT * from matcha.interests")
	interest_names = cur.fetchall()

	cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (session['id'], ))
	blocked = cur.fetchall()

	for interest in my_interests:
		for name in interest_names:
			if interest['interest_id'] == name['id']:
				interest['interest_id'] = name['interest']

	if request == 'default':
		if target_gender == "Both":
			cur.execute(sort, (session['id'], user_demands['target_min_age'], user_demands['target_max_age'], user_location, ))
		else:
			cur.execute(sort1, (session['id'], target_gender, user_demands['target_min_age'], user_demands['target_max_age'], user_location, ))
	elif request == 'filter':
		if target_gender == "Both":
			cur.execute(sort, (session['id'], my_user_demands['min_age'], my_user_demands['max_age'],
							my_user_demands['max_fame'], my_user_demands['min_fame'], user_location, ))
		else:
			cur.execute(sort1, (session['id'], target_gender, my_user_demands['min_age'], my_user_demands['max_age'],
							my_user_demands['max_fame'], my_user_demands['min_fame'], user_location, ))
	elif request == 'search':
		cur.execute(sort, (int(my_user_demands['min_age']), int(my_user_demands['max_age']),
							float(my_user_demands['max_fame']), float(my_user_demands['min_fame']), my_user_demands['max_location'], my_user_demands['max_location'],))
		my_users = cur.fetchall()

		app.logger.info(my_users)

		interests_p = my_user_demands['max_interests'].split(" ")
		users_p = []

		for p in interests_p:
			cur.execute('''SELECT matcha.users_interests.user_id, matcha.users_interests.interest_id,matcha.interests.interest FROM matcha.users_interests
						INNER JOIN matcha.interests ON matcha.interests.id=matcha.users_interests.interest_id
						WHERE matcha.interests.interest = %s''', (p, ))
			data = cur.fetchall()
			users_p.append(data)

		for p in users_p:
			if p == []:
				users_p.remove(p)

		if users_p != []:
			for user in my_users:
				user['tags'] = ""
				user['blocked'] = False

			for interest in users_p:
				for o in interest:
					for user in my_users:
						if o['user_id'] == user['id']:
							app.logger.info(user['username'])
							user['tags'] += o['interest']+" "

			for user in my_users:
				if user['tags'] == "":
					my_users.remove(user)

			for user in my_users:
				for block in blocked:
					if user['id'] == block['user_id']:
						user['blocked'] = True

	users = cur.fetchall()

	location = []

	for user in users:
		cur.execute('''SELECT * FROM matcha.users_location WHERE user_id = %s''', (user['id'], ))
		now_user = cur.fetchone()
		ky = 40000 / 360
		kx = math.cos(math.pi * locate_user['latitude'] / 180.0) * ky
		dx = math.fabs(locate_user['longitude'] - now_user['longitude']) * kx
		dx = math.fabs(locate_user['latitude'] - now_user['latitude']) * kx
		dy = math.fabs(locate_user['latitude'] - now_user['latitude']) * ky
		location.append({'id' : user['id'], 'location' : math.sqrt(dx * dx + dy * dy)})

	for user in users:
		user['common'] = 0
		user['interest'] = ""
		user['location_value'] = 0
		user['blocked'] = False

	for interest in my_interests:
		for user in users:
			if interest['recommended_user'] == user['id']:
				user['interest'] += interest['interest_id']+" "
				user['common'] += 1

	for place in location:
		for user in users:
			if place['id'] == user['id']:
				user['location_value'] = round(place['location'], 2)

	for user in users:
		for block in blocked:
			if user['id'] == block['user_id']:
				user['blocked'] = True

	cur.close()
	results = dict()

	if request == 'default':
		results['users'] = users
		results['interests'] = interests
	elif request == 'filter':
		for user in users:
			if user['location_value'] > float(my_user_demands['max_location']):
				users.remove(user)
		for user in users:
			if int(user['common']) < int(my_user_demands['max_interests']):
				user['common'] = 0
				
		results['users'] = users
		results['interests'] = interests
	elif request == 'search':
		results['users'] = my_users
		results['interests'] = users_p
	
	return results

app.config['UPLOADED_PHOTOS_DEST'] = r"/Users/kvilna/Desktop/uploads/"
photos = UploadSet('photos', IMAGES)
configure_uploads(app, photos)
patch_request_class(app)

# CONFIGURATION END

# INDEX

@app.route('/', defaults={'page': 1}, methods=['GET', 'POST'])
@app.route('/<int:page>')
def index(page):
	cur = mydb.cursor(buffered=True)
	cur.execute('''CREATE DATABASE IF NOT EXISTS matcha''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					username VARCHAR(255),
					name VARCHAR(255),
					last_name VARCHAR(255),
					email VARCHAR(255),
					password VARCHAR(255),
					verify BOOLEAN DEFAULT 0,
					login DATETIME,
					logout DATETIME,
					fame_rating DOUBLE DEFAULT 0.0)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_basic_info(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					gender VARCHAR(255) DEFAULT 'Unknown',
					bday_day INT(2) DEFAULT 1,
					bday_month INT(2) DEFAULT 1,
					bday_year INT(4) DEFAULT 1990,
					age INT(3) DEFAULT 28,
					target_gender VARCHAR(255) DEFAULT 'Both',
					target_min_age INT(11) DEFAULT 20,
					target_max_age INT(11) DEFAULT 50)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_appearance(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					height VARCHAR(255) DEFAULT 'Unknown',
					body_type VARCHAR(255) DEFAULT 'Unknown',
					hair_color VARCHAR(255) DEFAULT 'Unknown',
					eye_color VARCHAR(255) DEFAULT 'Unknown',
					hair_type VARCHAR(255) DEFAULT 'Unknown')''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_lifestyle(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					relationship_status VARCHAR(255) DEFAULT 'Unknown', 
					children VARCHAR(255) DEFAULT 'Unknown',
					would_like_children VARCHAR(255) DEFAULT 'Unknown',
					diet VARCHAR(255) DEFAULT 'Unknown',
					drinking VARCHAR(255) DEFAULT 'Unknown',
					smoking VARCHAR(255) DEFAULT 'Unknown')''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_background(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					education VARCHAR(255) DEFAULT 'Unknown',
					employment VARCHAR(255) DEFAULT 'Unknown',
					occupation VARCHAR(255) DEFAULT 'Unknown',
					languages VARCHAR(255) DEFAULT 'Unknown')''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_description(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					about_me VARCHAR(8000) DEFAULT 'There is nothing interesting about me',
					about_target VARCHAR(8000) DEFAULT 'I have no idea of who I am looking for')''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_pictures(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					profile_pic VARCHAR(255) DEFAULT 'static/img/default_profile.jpg')''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_files_upload(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					upload_pic TEXT)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_location(
					id INT(11) AUTO_INCREMENT PRIMARY KEY,
					user_id INT(11),
					country VARCHAR(100) DEFAULT 'Unknown',
					city VARCHAR(100) DEFAULT 'Unknown',
					district VARCHAR(100) DEFAULT 'Unknown',
					user_country VARCHAR(100) DEFAULT 'Unknown',
					user_city VARCHAR(100) DEFAULT 'Unknown',
					user_district VARCHAR(100) DEFAULT 'Unknown',
					latitude DOUBLE,
					longitude DOUBLE,
					backup_lat DOUBLE,
					backup_lon DOUBLE)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.interests(
					id INT(11),
					interest VARCHAR(255))''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_interests(
					user_id INT(11),
					interest_id INT(11))''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_visits(
					user_id INT(11),
					visit_id INT(11),
					visit_time DATETIME)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_likes(
					user_id INT(11),
					like_id INT(11))''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.notifications(
					user_id INT(11),
					message BOOLEAN DEFAULT 1,
					new_like BOOLEAN DEFAULT 1,
					unlike BOOLEAN DEFAULT 1,
					profile_check BOOLEAN DEFAULT 1,
					mutual_like BOOLEAN DEFAULT 1)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.messages(
					sender_id INT(11),
					recipient_id INT(11),
					message TEXT)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.notification_box(
					current_user_id INT(11),
					other_user_id INT(11),
					message TEXT)''')
	cur.execute('''CREATE TABLE IF NOT EXISTS matcha.users_blocked(
					user_id INT(11),
					blocked_by_user_id INT(11))''')
	mydb.commit()

	cur.execute("SELECT * FROM matcha.interests")
	res = cur.rowcount
	if res == 0:
		val = [
			(1, 'geek'), 
			(2, 'travelling'), 
			(3, 'reading'), 
			(4, 'workout'), 
			(5, 'sports'), 
			(6, 'fishing'), 
			(7, 'rap'), 
			(8, 'rock'), 
			(9, 'pop'),
			(10, 'art'), 
			(11, 'piercing'), 
			(12, 'comics'), 
			(13, 'programming'), 
			(14, 'tattoos'),
			(15, 'videogames'),
			(16, 'history'),
			(17, 'medicine'),
			(18, 'movies'),
			(19, 'foreign_languages'),
			(20, 'photography'),
			(21, 'handmade'),
			(22, 'dancing'),
			(23, 'chess'),
			(24, 'fashion'),
			(25, 'board_games'),
			(26, 'horse_riding'),
			(27, 'running'),
			(28, 'football'),
			(29, 'baseball'),
			(30, 'basketball'),
			(31, 'skateboarding'),
			(32, 'birdwatching'),
			(33, 'hiking'),
			(34, 'biking'),
			(35, 'cooking'),
			(36, 'cosplay')
		]
		cur.executemany('''INSERT INTO matcha.interests (id, interest) VALUES (%s, %s)''', val)
		mydb.commit()

	cur.close()
	if request.method == 'POST':
		users = "none"
		username = request.form.get('username', False)
		name = request.form.get('name', False)
		lastname = request.form.get('lastname', False)
		email = request.form.get('email', False)
		password_check = request.form.get('password', False)
		confirm = request.form.get('confirm', False)

		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (username,))
		result = cur.rowcount
		cur.close()

		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE email = %s", (email,))
		result2 = cur.rowcount
		cur.close()

		if result != 0:
			message = "User with this name already exists"
			return render_template('home.html', page='index', error=message)

		if result2 != 0:
			message = "User with this email already exists"
			return render_template('home.html', page='index', error=message)

		if validate_email(email) == False:
			message = "Wrong format email"
			return render_template('home.html', error=message)
		if validate_password(password_check) == False:
			message = "Your password should contain at least one number and one uppercase letter"
			return render_template('home.html', error=message)
		if confirm_password(password_check, confirm) == False:
			message = "Passwords don't match"
			return render_template('home.html', error=message)
		
		password = sha256_crypt.encrypt(str(password_check))

		cur = mydb.cursor()
		query = "INSERT INTO matcha.users(username, name, last_name, email, password) VALUES(%s, %s, %s, %s, %s)"
		cur.execute(query, (username, name, lastname, email, password))
		mydb.commit()
		cur.close()

		theme = "Complete registration"
		token = s.dumps(email, salt='email-confirm')
		arguments = {
			"username" : username,
			"token" : token
		}

		send_message(app, theme, email, 'verify', mail, arguments)

		flash('Please verify your email to log in', 'success')

	if 'id' in session:
		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
		notifications = cur.fetchall()
		cur.close()

		session['notifications'] = notifications

		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE matcha.users.id != %s", (session['id'], ))
		num_pages = cur.rowcount / 10
		if cur.rowcount % 10 != 0:
			num_pages = cur.rowcount / 10 + 1
		pages = []
		pages_temp = 1
		while pages_temp <= num_pages:
			pages.append(pages_temp)
			pages_temp += 1
		cur.execute('''SELECT * FROM matcha.users
						INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
						INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
						INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
						WHERE matcha.users.id != %s
						ORDER BY fame_rating DESC LIMIT %s, %s''', (session['id'], page * 10 - 10, 10, ))
		users = cur.fetchall()
		cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (session['id'], ))
		blocked = cur.fetchall()

		for user in users:
			user['blocked'] = False

		for user in users:
			for block in blocked:
				if user['id'] == block['user_id']:
					user['blocked'] = True
		age = []
		for part in users:
			cur.execute("SELECT TIMESTAMPDIFF(YEAR, '%s-%s-%s', CURDATE()) AS age", (part['bday_year'], part['bday_month'], part['bday_day'], ))
			user_age = cur.fetchone()
			age.append((part['user_id'], user_age))
		cur.execute("SELECT * FROM matcha.users_location LIMIT %s, %s", (page * 10 - 10, 10, ))
		location = cur.fetchall()
		cur.close()
		return render_template('home.html', page='index', pages=pages, users=users, age=age, location=location, blocked=blocked)
	return render_template('home.html', page='index')

# INDEX END

@app.route('/advanced-search', methods=['GET', 'POST'])
def advanced_search():
	my_request = 'search'
	my_user_demands = {}
	if request.args.get('min_age'):
		my_user_demands['min_age'] = request.args.get('min_age')
		my_user_demands['max_age'] = request.args.get('max_age')
		my_user_demands['min_fame'] = request.args.get('min_fame')
		my_user_demands['max_fame'] = request.args.get('max_fame')
		my_user_demands['max_location'] = request.args.get('max_location')
		my_user_demands['max_interests'] = request.args.get('max_interests')
	else:
		my_user_demands['min_age'] = 20
		my_user_demands['max_age'] = 50
		my_user_demands['min_fame'] = 0
		my_user_demands['max_fame'] = 1
		my_user_demands['max_location'] = "Kyiv"
		my_user_demands['max_interests'] = ""

	sort = '''SELECT matcha.users.id, matcha.users.name, matcha.users.last_name, matcha.users.username, matcha.users.logout,
				matcha.users.fame_rating, matcha.users_pictures.profile_pic, matcha.users_basic_info.age,
				matcha.users_basic_info.gender, matcha.users_basic_info.target_gender, matcha.users_location.city, matcha.users_location.latitude,
				matcha.users_location.longitude, matcha.users_location.user_city FROM matcha.users
				INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
				INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
				INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
				WHERE matcha.users_basic_info.age >= %s 
				AND matcha.users_basic_info.age <= %s
				AND matcha.users.fame_rating <= %s
				AND matcha.users.fame_rating >= %s
				AND ((matcha.users_location.city = 'Unknown' AND matcha.users_location.user_city = %s)
				OR (matcha.users_location.city = %s AND matcha.users_location.user_city = 'Unknown'))'''
	sort1 = ""
	results = get_users(sort, sort1, my_request, my_user_demands)
	cur = mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.interests")
	all_interests = cur.fetchall()
	cur.execute("SELECT DISTINCT matcha.users_location.city, matcha.users_location.user_city FROM matcha.users_location")
	all_locations = cur.fetchall()
	cur.close()
	return render_template('search.html', users=results['users'], interests_id=results['interests'], all_interests=all_interests, all_locations=all_locations)

@app.route('/map', methods=['GET', 'POST'])
def map():
	cur = mydb.cursor(buffered=True, dictionary=True)
	cur.execute('''SELECT matcha.users.id, matcha.users.username, matcha.users.name, matcha.users.last_name,
				matcha.users_location.latitude, matcha.users_location.longitude, matcha.users_pictures.profile_pic FROM matcha.users
				INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
				INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id''')
	users = cur.fetchall()
	cur.close()
	return render_template('map.html', users=users)

@socketio.on('my event')
def handle_my_custom_event(json, methods=['GET', 'POST']):
	if 'recieve_name' in json:
		s_mydb = mysql.connector.connect(**config)

		notify = True

		cur = s_mydb.cursor(buffered=True, dictionary=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (json['recieve_name'], ))
		user_id = cur.fetchone()
		cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (user_id['id'], ))
		blocked = cur.fetchall()
		for block in blocked:
			if int(json['sender_id']) == int(block['user_id']):
				notify = False
				json['message'] = 'false'
		cur.execute("INSERT INTO matcha.messages(sender_id, recipient_id, message) VALUES (%s, %s, %s)", (json['sender_id'], user_id['id'], json['message'], ))
		if notify == True:
			if json['is_chats'] != 'chats':
				cur.execute("INSERT INTO matcha.notification_box (current_user_id, other_user_id, message) VALUES(%s, %s, %s)", (user_id['id'], json['sender_id'], "you got a new message from "+json['sender_name'], ))
			cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (user_id['id'], ))
			settings = cur.fetchone()
			if settings['message'] == 1:
				theme = "Someone wrote you a message!"
				arguments = {
					"who_sent" : json['sender_id'],
					"my_username" : json['recieve_name'],
					"message" : json['message'],
				}
				send_message(app, theme, user_id['email'], 'message', mail, arguments)
		s_mydb.commit()
		cur.close()
		s_mydb.close()
		app.logger.info("my event exit")
		socketio.emit('my response', json)

@socketio.on('profile check')
def handle_my_custom_event(json, methods=['GET', 'POST']):
	if json:
		s_mydb = mysql.connector.connect(**config)
		notify = True
		cur = s_mydb.cursor(buffered=True, dictionary=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (json['host_name'], ))
		user_id = cur.fetchone()
		cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (user_id['id'], ))
		blocked = cur.fetchall()
		for block in blocked:
			if int(json['visitor_id']) == int(block['user_id']):
				notify = False
				json['message'] = 'false'
		if notify == True:
			cur.execute("INSERT INTO matcha.notification_box (current_user_id, other_user_id, message) VALUES(%s, %s, %s)", (user_id['id'], json['visitor_id'], json['message'], ))
			cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (user_id['id'], ))
			settings = cur.fetchone()
			if settings['profile_check'] == 1:
				theme = "Someone checked your profile!"
				arguments = {
					"who_checked" : json['visitor_name'],
					"my_username" : json['host_name'],
				}
				send_message(app, theme, user_id['email'], 'profile_check', mail, arguments)
		s_mydb.commit()
		cur.close()
		s_mydb.close()
		app.logger.info("my profile exit")
		socketio.emit('profile response', json)

@socketio.on('like event')
def handle_my_custom_event(json, methods=['GET', 'POST']):
	if json:
		s_mydb = mysql.connector.connect(**config)
		notify = True
		cur = s_mydb.cursor(buffered=True, dictionary=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (json['host_name'], ))
		user_id = cur.fetchone()
		cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (user_id['id'], ))
		basic = cur.fetchone()
		cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (user_id['id'], ))
		blocked = cur.fetchall()
		for block in blocked:
			if int(json['visitor_id']) == int(block['user_id']):
				notify = False
				json['message'] = 'false'
		if notify == True:
			cur.execute("INSERT INTO matcha.notification_box (current_user_id, other_user_id, message) VALUES(%s, %s, %s)", (user_id['id'], json['visitor_id'], json['notification'], ))
			s_mydb.commit()
			cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (user_id['id'], ))
			settings = cur.fetchone()

			if settings['new_like'] == 1:
				theme = "You recieved a new like!"
				arguments = {
					"who_liked" : json['visitor_name'],
					"my_username" : json['host_name'],
					"gender" : basic['gender']
				}
				send_message(app, theme, user_id['email'], 'new_like', mail, arguments)
		cur.close()
		s_mydb.close()
		app.logger.info("my like exit")
		socketio.emit('like response', json)

@socketio.on('dislike event')
def handle_my_custom_event(json, methods=['GET', 'POST']):
	if json:
		s_mydb = mysql.connector.connect(**config)
		notify = True
		cur = s_mydb.cursor(buffered=True, dictionary=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (json['host_name'], ))
		user_id = cur.fetchone()
		cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (user_id['id'], ))
		basic = cur.fetchone()
		cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (user_id['id'], ))
		blocked = cur.fetchall()
		for block in blocked:
			if int(json['visitor_id']) == int(block['user_id']):
				notify = False
				json['message'] = 'false'
		if notify == True:
			cur.execute("INSERT INTO matcha.notification_box (current_user_id, other_user_id, message) VALUES(%s, %s, %s)", (user_id['id'], json['visitor_id'], json['notification'], ))
			s_mydb.commit()
			cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (user_id['id'], ))
			settings = cur.fetchone()

			if settings['unlike'] == 1:
				theme = "Someone unliked you :("
				arguments = {
					"who_unliked" : json['visitor_name'],
					"my_username" : json['host_name']
				}
				send_message(app, theme, user_id['email'], 'unlike', mail, arguments)
		cur.close()
		s_mydb.close()
		app.logger.info("my dislike exit")
		socketio.emit('dislike response', json)

@socketio.on('connection event')
def handle_my_custom_event(json, methods=['GET', 'POST']):
	if json:
		s_mydb = mysql.connector.connect(**config)
		notify = True
		cur = s_mydb.cursor(buffered=True, dictionary=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (json['host_name'], ))
		user_id = cur.fetchone()
		cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (user_id['id'], ))
		basic = cur.fetchone()
		cur.execute('''SELECT * FROM matcha.users_blocked WHERE blocked_by_user_id = %s''', (user_id['id'], ))
		blocked = cur.fetchall()
		for block in blocked:
			if int(json['visitor_id']) == int(block['user_id']):
				notify = False
				json['message'] = 'false'
		if notify == True:
			cur.execute("INSERT INTO matcha.notification_box (current_user_id, other_user_id, message) VALUES(%s, %s, %s)", (user_id['id'], json['visitor_id'], json['notification'], ))
			s_mydb.commit()
			cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (user_id['id'], ))
			settings = cur.fetchone()

			if settings['mutual_like'] == 1:
				theme = "You got a new connection"
				arguments = {
					"who_liked" : json['visitor_name'],
					"my_username" : json['host_name']
				}
				send_message(app, theme, user_id['email'], 'mutual_like', mail, arguments)
		cur.close()
		s_mydb.close()
		app.logger.info("my connection exit")
		socketio.emit('connection response', json)

# USER AUTHORIZATION

@app.route('/login', methods=['GET', 'POST'])
@is_logged_out
def login():
	if request.method == 'POST':
		username = request.form.get('username', False)
		password_candidate = request.form.get('password', False)

		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE username = %s", (username,))
		result = cur.rowcount
		
		if result > 0:
			data = cur.fetchone()
			cur.close()
			password = data['password']
			verify = data['verify']

			if verify == 0:
				flash('Please, verify your email to log in', 'danger')
				return redirect(url_for('unconfirmed'))

			if sha256_crypt.verify(password_candidate, password):
				cur = mydb.cursor(dictionary=True, buffered=True)
				cur.execute("SELECT * FROM matcha.users_pictures WHERE user_id = %s", (data['id'], ))
				pic = cur.fetchone()

				result = cur.rowcount
				if result == 1:
					profile_pic = pic['profile_pic']
				else:
					cur.execute("INSERT INTO matcha.users_pictures(user_id) VALUES (%s)", (data['id'], ))
					mydb.commit()
					profile_pic = "static/img/default_profile.jpg"
				cur.close()

				session['logged_in'] = True
				session['username'] = username
				session['profile_pic'] = profile_pic
				session['id'] = data['id']

				cur = mydb.cursor(dictionary=True, buffered=True)
				cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.users_basic_info (user_id) VALUES(%s)", (session['id'], ))

				cur.execute("SELECT * FROM matcha.users_appearance WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.users_appearance (user_id) VALUES(%s)", (session['id'], ))
				
				cur.execute("SELECT * FROM matcha.users_description WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.users_description (user_id) VALUES(%s)", (session['id'], ))

				cur.execute("SELECT * FROM matcha.users_background WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.users_background (user_id) VALUES(%s)", (session['id'], ))
				
				cur.execute("SELECT * FROM matcha.users_lifestyle WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.users_lifestyle (user_id) VALUES(%s)", (session['id'], ))

				cur.execute("SELECT * FROM matcha.users_location WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.users_location (user_id) VALUES(%s)", (session['id'], ))

				cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (session['id'],))
				result = cur.rowcount
				if result != 1:
					cur.execute("INSERT INTO matcha.notifications (user_id) VALUES(%s)", (session['id'], ))

				cur.execute("UPDATE matcha.users SET login = NOW() WHERE id = %s", (session['id'], ))
				cur.execute("UPDATE matcha.users SET logout = NULL WHERE id = %s", (session['id'], ))
	
				mydb.commit()
				cur.close()

				flash('You are now logged in', 'success')
				return redirect(url_for('profile', username=username))
			else:
				error = 'Invalid password'
			return render_template('login.html', error=error)
		else:
			error = 'Username not found'
			return render_template('login.html', error=error)

	return render_template('login.html')

@app.route('/recommendations', defaults={'page': 1}, methods=['GET', 'POST'])
@app.route('/recommendations/<int:page>')
@is_logged_in
def recommend(page):
	my_request = 'default'
	my_user_demands = {}
	if request.args.get('min_age'):
		my_user_demands['min_age'] = request.args.get('min_age')
		my_user_demands['max_age'] = request.args.get('max_age')
		my_user_demands['min_fame'] = request.args.get('min_fame')
		my_user_demands['max_fame'] = request.args.get('max_fame')
		my_user_demands['max_location'] = request.args.get('max_location')
		my_user_demands['max_interests'] = request.args.get('max_interests')
		my_request = 'filter'

		sort = '''SELECT matcha.users.id, matcha.users.name, matcha.users.last_name, matcha.users.username, matcha.users.logout,
					matcha.users.fame_rating, matcha.users_pictures.profile_pic, matcha.users_basic_info.age,
					matcha.users_basic_info.gender, matcha.users_basic_info.target_gender, matcha.users_location.city, matcha.users_location.latitude,
					matcha.users_location.longitude, matcha.users_location.user_city FROM matcha.users
					INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
					INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
					INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
					WHERE matcha.users.id != %s
					AND matcha.users_basic_info.age >= %s 
					AND matcha.users_basic_info.age <= %s
					AND matcha.users.fame_rating <= %s
					AND matcha.users.fame_rating >= %s
					AND matcha.users_location.city = %s'''
		sort1 = '''SELECT matcha.users.id, matcha.users.name, matcha.users.last_name, matcha.users.username, matcha.users.logout,
					matcha.users.fame_rating, matcha.users_pictures.profile_pic, matcha.users_basic_info.age,
					matcha.users_basic_info.gender, matcha.users_basic_info.target_gender, matcha.users_location.city, matcha.users_location.latitude,
					matcha.users_location.user_city, matcha.users_location.longitude FROM matcha.users
					INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
					INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
					INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
					WHERE matcha.users.id != %s
					AND matcha.users_basic_info.gender = %s
					AND matcha.users_basic_info.age >= %s
					AND matcha.users_basic_info.age <= %s
					AND matcha.users.fame_rating <= %s
					AND matcha.users.fame_rating >= %s
					AND matcha.users_location.city = %s'''
	else:
		sort = '''SELECT matcha.users.id, matcha.users.name, matcha.users.last_name, matcha.users.username, matcha.users.logout,
					matcha.users.fame_rating, matcha.users_pictures.profile_pic, matcha.users_basic_info.age,
					matcha.users_basic_info.gender, matcha.users_basic_info.target_gender, matcha.users_location.city, matcha.users_location.latitude,
					matcha.users_location.longitude, matcha.users_location.user_city FROM matcha.users
					INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
					INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
					INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
					WHERE matcha.users.id != %s
					AND matcha.users_basic_info.age >= %s 
					AND matcha.users_basic_info.age <= %s
					AND matcha.users_location.city = %s
					ORDER BY matcha.users.id ASC'''
		sort1 = '''SELECT matcha.users.id, matcha.users.name, matcha.users.last_name, matcha.users.username, matcha.users.logout,
					matcha.users.fame_rating, matcha.users_pictures.profile_pic, matcha.users_basic_info.age,
					matcha.users_basic_info.gender, matcha.users_basic_info.target_gender, matcha.users_location.city, matcha.users_location.latitude,
					matcha.users_location.user_city, matcha.users_location.longitude FROM matcha.users
					INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
					INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id
					INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
					WHERE matcha.users.id != %s
					AND matcha.users_basic_info.gender = %s
					AND matcha.users_basic_info.age >= %s 
					AND matcha.users_basic_info.age <= %s
					AND matcha.users_location.city = %s
					ORDER BY matcha.users.id ASC'''
	results = get_users(sort, sort1, my_request, my_user_demands)
	return render_template('recommend.html', users=results['users'], interests=results['interests'])


@app.route('/complete/<token>', methods=['GET'])
def complete(token):
	try:
		email = s.loads(token, salt='email-confirm', max_age=3600)
		flash('Success! You can now log in', 'success')
		cur = mydb.cursor()
		query = "UPDATE matcha.users SET verify = 1 WHERE email = %s"
		cur.execute(query, (email, ))
		mydb.commit()
		cur.close()
		return redirect(url_for('login'))
	except SignatureExpired:
		flash('Your token expired. Please, try again.', 'danger')
		return redirect(url_for('unconfirmed'))

# USER AUTHORIZATION END

# ISSUES WITH AUTHORIZATION 

@app.route('/unconfirmed', methods=['GET', 'POST'])
@is_logged_out
def unconfirmed():
	if request.method == 'POST':
		email = request.form.get('email', False)
		if validate_email(email) == False:
			message = "Wrong format email"
			return render_template('home.html', error=message)

		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE email = %s", (email,))
		result = cur.rowcount
		if result > 0:
			data = cur.fetchone()
			username = data['username']

			theme = "Complete registration"
			token = s.dumps(email, salt='email-confirm')
			arguments = {
				"username" : username,
				"token" : token
			}

			send_message(app, theme, email, 'verify', mail, arguments)

			flash('Please verify your email to log in', 'success')
			cur.close()
			return redirect(url_for('index'))
		else:
			error = 'Email not found. Please, register again using your email'
			cur.close()
			return render_template('home.html', error=error)
	return render_template('unconfirmed.html')

@app.route('/password_reset', methods=['GET', 'POST'])
@is_logged_out
def password_reset():
	if request.method == 'POST':
		email = request.form.get('email', False)
		if validate_email(email) == False:
			message = "Wrong format email"
			return render_template('home.html', error=message)

		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE email = %s", (email,))
		result = cur.rowcount
		if result > 0:
			data = cur.fetchone()
			username = data['username']

			theme = "Reset password"
			token = s.dumps(email, salt='password-reset')
			arguments = {
				"username" : username,
				"token" : token
			}

			send_message(app, theme, email, 'reset_pass', mail, arguments)

			flash('Please check your email', 'success')
			cur.close()
			return redirect(url_for('index'))
		else:
			error = 'Email not found. Please, register again using your email'
			cur.close()
			return render_template('home.html', error=error)
	return render_template('password_reset.html')

@app.route('/password_reset_finish/<token>', methods=['GET', 'POST'])
def password_reset_finish(token):
	try:
		email = s.loads(token, salt='password-reset', max_age=3600)
	except SignatureExpired:
		flash('Your token expired. Please, try again.', 'danger')
		return redirect(url_for('password_reset'))

	if request.method == 'POST':
		password_check = request.form.get('password', False)
		confirm = request.form.get('confirm', False)

		if validate_password(password_check) == False:
			message = "Your password should contain at least one number and one uppercase letter"
			return render_template('password_reset_finish.html', error=message)
		if confirm_password(password_check, confirm) == False:
			message = "Passwords don't match"
			return render_template('password_reset_finish.html', error=message)

		password = sha256_crypt.encrypt(str(password_check))
		cur = mydb.cursor()
		query = "UPDATE matcha.users SET password = %s WHERE email = %s"
		cur.execute(query, (password, email, ))
		mydb.commit()
		cur.close()
		flash('Your password was successfully changed. You can now log in', 'success')
		return redirect(url_for('login'))
	return render_template('password_reset_finish.html')

# ISSUES WITH AUTHORIZATION END

# LOGOUT

# def is_logged_in(f):
# 	@wraps(f)
# 	def wrap(*args, **kwargs):
# 		if 'logged_in' in session:
# 			return f(*args, **kwargs)
# 		else:
# 			flash('Unauthorized. Please, log in', 'danger')
# 			return redirect(url_for('login'))
# 	return wrap

@app.route('/logout')
@is_logged_in
def logout():
	cur = mydb.cursor()
	cur.execute("UPDATE matcha.users SET logout = NOW() WHERE id = %s", (session['id'], ))
	mydb.commit()
	cur.close()
	session.clear()
	flash('You are now logged out', 'success')
	return redirect(url_for('login'))

# LOGOUT END

# USER PROFILE

@app.route('/edit', methods=['GET', 'POST'])
@is_logged_in
def edit():

	temp_mydb = mysql.connector.connect(**config)

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_appearance WHERE user_id = %s", (session['id'], ))
	appearance = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (session['id'], ))
	basic = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_lifestyle WHERE user_id = %s", (session['id'], ))
	lifestyle = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_background WHERE user_id = %s", (session['id'], ))
	background = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_description WHERE user_id = %s", (session['id'], ))
	description = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_location WHERE user_id = %s", (session['id'], ))
	locate = cur.fetchone()
	cur.close()

	if locate['user_city'] == 'Unknown':
		city = locate['city']
		country = locate['country']
		district = locate['district']
	else:
		city = locate['user_city']
		country = locate['user_country']
		district = locate['user_district']

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.interests")
	interests = cur.fetchall()
	cur.close()

	my_interests = []

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT interest_id FROM matcha.users_interests WHERE user_id = %s", (session['id'], ))
	my_interests_id = cur.fetchall()

	app.logger.info(my_interests_id)

	for interest in my_interests_id:
		cur = temp_mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.interests WHERE id = %s", (interest['interest_id'], ))
		data = cur.fetchone()
		my_interests.append(data)
		cur.close()
		app.logger.info(interest['interest_id'])
	cur.close()
	temp_mydb.close()

	return render_template('edit.html', basic=basic, appearance=appearance, lifestyle=lifestyle, background=background,
		description=description, city=city,	country=country, district=district, interests=interests, my_interests=my_interests)

@app.route('/save-basic-info', methods=['GET', 'POST'])
def save_basic_info():
	gender = request.form['gender']
	birthday = request.form['day'] + request.form['month'] + request.form['year']
	target_gender = request.form['looking_for']
	min_age = request.form['min_age']
	max_age = request.form['max_age']

	app.logger.info(request.form['day'])
	if int(request.form['day']) > 31 or int(request.form['day']) < 1 or int(request.form['month']) > 12 or int(request.form['month']) < 1:
		app.logger.info("here for some reason")
		return jsonify({'error' : 'Ooopsie. Something went wrong :('})

	today = date.today()
	age = today.year - int(request.form['year']) - ((today.month, today.day) < (int(request.form['month']), int(request.form['day'])))

	cur = mydb.cursor()
	query = '''UPDATE matcha.users_basic_info SET
				gender = %s,
				bday_day = %s,
				bday_month = %s,
				bday_year = %s,
				age = %s,
				target_gender = %s,
				target_min_age = %s,
				target_max_age = %s
				WHERE
				user_id = %s'''
	cur.execute(query, (gender, request.form['day'], request.form['month'], request.form['year'], age ,target_gender, min_age, max_age, session['id'], ))
	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})
	# return jsonify({'error' : 'Ooopsie :( Something went wrong'})

@app.route('/save-user-location', methods=['GET', 'POST'])
def save_user_location():
	cur = mydb.cursor(dictionary=True)
	cur.execute("SELECT * FROM matcha.users_location WHERE user_id = %s", (session['id'], ))
	coordinates = cur.fetchone()
	cur.close()

	location = geolocator.geocode(request.form['city'], language='en', addressdetails=True)
	user_district = "none"
	city = "Unknown"
	country = "Unknown"

	latitude = coordinates['latitude']
	longitude = coordinates['longitude']

	if location == None:
		return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})

	if 'address' in location.raw:
		if 'city' in location.raw['address']:
			location.raw['address']['city']
			if request.form['city'] == location.raw['address']['city']:
				city = request.form['city']
				country = location.raw['address']['country']
				latitude = location.raw['lat']
				longitude = location.raw['lon']
			else:
				return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})
		elif 'town' in location.raw['address']:
			if request.form['city'] == location.raw['address']['town']:
				city = request.form['city']
				country = location.raw['address']['country']
				latitude = location.raw['lat']
				longitude = location.raw['lon']
			else:
				return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})
		elif 'county' in location.raw['address']:
			if request.form['city'] == location.raw['address']['county']:
				city = request.form['city']
				country = location.raw['address']['country']
				latitude = location.raw['lat']
				longitude = location.raw['lon']
			else:
				return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})
		elif 'city_district' in location.raw['address']:
			if request.form['city'] == location.raw['address']['city_district']:
				city = request.form['city']
				country = location.raw['address']['country']
				latitude = location.raw['lat']
				longitude = location.raw['lon']
			else:
				return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})

		elif 'state' in location.raw['address']:
			if request.form['city'] == location.raw['address']['state']:
				city = request.form['city']
				country = location.raw['address']['country']
				latitude = location.raw['lat']
				longitude = location.raw['lon']
			else:
				return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})
		else:
			return jsonify({'error' : 'It seems like the city you entered doesn\'t exist. Check the spelling or just take it easy'})


	district = geolocator.geocode(request.form['district'], language='en', addressdetails=True)

	if district != None and 'address' in district.raw:
		if 'city' in district.raw['address']:
			if request.form['city'] == district.raw['address']['city']:
				user_district = request.form['district']
		elif 'town' in district.raw['address']:
			if request.form['city'] == district.raw['address']['town']:
				user_district = request.form['district']
		elif 'county' in location.raw['address']:
			if request.form['city'] == location.raw['address']['county']:
				user_district = request.form['district']
		elif 'city_district' in location.raw['address']:
			if request.form['city'] == location.raw['address']['city_district']:
				user_district = request.form['district']
		elif 'state' in location.raw['address']:
			if request.form['city'] == location.raw['address']['state']:
				user_district = request.form['district']
	
	cur = mydb.cursor()
	cur.execute('''UPDATE matcha.users_location SET city = "Unknown", user_city = %s, user_district = %s, user_country = %s, latitude = %s, longitude = %s WHERE user_id = %s''',
								(city, user_district, country, latitude, longitude, session['id'], ))

	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})


@app.route('/location', methods=['GET', 'POST'])
def location():
	if request.form['latitude'] and request.form['longitude'] and request.form['backup_lat'] and request.form['backup_lon']:
		latitude = request.form['latitude']
		longitude = request.form['longitude']
		backup_lat = request.form['backup_lat']
		backup_lon = request.form['backup_lon']

		coordinates = (latitude, longitude)
		location = geolocator.reverse(coordinates, language='en')

		cur = mydb.cursor(buffered=True)

		query = '''UPDATE matcha.users_location SET
					country = %s,
					city = %s,
					district = %s,
					latitude = %s,
					longitude = %s,
					backup_lat = %s,
					backup_lon = %s
					WHERE
					user_id = %s'''
		cur.execute(query, (location.raw['address']['country'], location.raw['address']['city'],
					location.raw['address']['suburb'], latitude, longitude, backup_lat, backup_lon, session['id'], ))
		mydb.commit()
		cur.close()

	return 'OK'

@app.route('/save-appearance', methods=['GET', 'POST'])
def save_appearance():
	height = request.form['height']
	body_type = request.form['body_type']
	hair_color = request.form['hair_color']
	eye_color = request.form['eye_color']
	hair_type = request.form['hair_type']

	cur = mydb.cursor()
	query = '''UPDATE matcha.users_appearance
				SET
				height = %s,
				body_type = %s,
				hair_color = %s,
				eye_color = %s,
				hair_type = %s
				WHERE
				user_id = %s'''
	cur.execute(query, (height, body_type, hair_color, eye_color, hair_type, session['id'], ))
	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})
	# return jsonify({'error' : 'Ooopsie :( Something went wrong'})

@app.route('/save-lifestyle', methods=['GET', 'POST'])
def save_lifestyle():
	relationship_status = request.form['relationship_status']
	children = request.form['children']
	would_like_children = request.form['would_like_children']
	diet = request.form['diet']
	drinking = request.form['drinking']
	smoking = request.form['smoking']

	cur = mydb.cursor()
	query = '''UPDATE matcha.users_lifestyle
				SET
				relationship_status = %s,
				children = %s,
				would_like_children = %s,
				diet = %s,
				drinking = %s,
				smoking = %s
				WHERE
				user_id = %s'''
	cur.execute(query, (relationship_status, children, would_like_children, diet, drinking, smoking, session['id'], ))
	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})
	# return jsonify({'error' : 'Ooopsie :( Something went wrong'})

@app.route('/save-background', methods=['GET', 'POST'])
def save_background():
	education = request.form['education']
	employment = request.form['employment']
	occupation = request.form['occupation']
	languages = request.form['languages']
	if languages == "":
		languages = 'Unknown'
	
	cur = mydb.cursor()
	query = '''UPDATE matcha.users_background
				SET
				education = %s,
				employment = %s,
				occupation = %s,
				languages = %s
				WHERE
				user_id = %s'''
	cur.execute(query, (education, employment, occupation, languages, session['id'], ))
	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})
	# return jsonify({'error' : 'Ooopsie :( Something went wrong'})

@app.route('/save-description', methods=['GET', 'POST'])
def save_description():
	about_me = request.form['about_me']
	about_target = request.form['about_target']

	cur = mydb.cursor()
	query = "UPDATE matcha.users_description SET about_me = %s, about_target = %s WHERE user_id = %s"
	cur.execute(query, (about_me, about_target, session['id'], ))
	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})
	# return jsonify({'error' : 'Ooopsie :( Something went wrong'})


@app.route('/profile/<username>')
@is_logged_in
def profile(username):
	
	temp_mydb = mysql.connector.connect(**config)

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute('''SELECT *, DATE_FORMAT(logout, '%a, %H:%i') AS logout FROM
				matcha.users WHERE username = %s''', (username, ))
	data = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_pictures WHERE user_id = %s", (data['id'], ))
	pic = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_appearance WHERE user_id = %s", (data['id'], ))
	appearance = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (data['id'], ))
	basic = cur.fetchone()
	cur.execute("SELECT TIMESTAMPDIFF(YEAR, '%s-%s-%s', CURDATE()) AS age", (basic['bday_year'], basic['bday_month'], basic['bday_day'], ))
	age = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_lifestyle WHERE user_id = %s", (data['id'], ))
	lifestyle = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_background WHERE user_id = %s", (data['id'], ))
	background = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_description WHERE user_id = %s", (data['id'], ))
	description = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_files_upload WHERE user_id = %s", (data['id'], ))
	num_photos = cur.rowcount
	if num_photos != 0:
		photos = cur.fetchall()
	else:
		photos = "none"
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_location WHERE user_id = %s", (data['id'], ))
	locate = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_likes WHERE user_id = %s AND like_id = %s", (data['id'], session['id'], ))
	likes = cur.rowcount
	mutual = False
	if likes == 1:
		likes = True
		cur.execute("SELECT * FROM matcha.users_likes WHERE user_id = %s AND like_id = %s", (session['id'], data['id'], ))
		num_mutual = cur.rowcount
		if num_mutual == 1:
			if session['profile_pic'] != "static/img/default_profile.jpg":
				mutual = True
	if likes == 0:
		likes = False
	cur.close()

	if locate['user_city'] == 'Unknown':
		city = locate['city']
		country = locate['country']
		district = locate['district']
	else:
		city = locate['user_city']
		country = locate['user_country']
		district = locate['user_district']

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.interests")
	interests = cur.fetchall()
	cur.close()

	my_interests = []

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT interest_id FROM matcha.users_interests WHERE user_id = %s", (data['id'], ))
	my_interests_id = cur.fetchall()

	for interest in my_interests_id:
		cur = temp_mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.interests WHERE id = %s", (interest['interest_id'], ))
		value = cur.fetchone()
		my_interests.append(value)
		cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (data['id'], ))
	settings = cur.fetchone()
	cur.close()

	if data['id'] != session['id']:
		cur = temp_mydb.cursor(dictionary=True, buffered=True)
		cur.execute("INSERT INTO matcha.users_visits (user_id, visit_id, visit_time) VALUES (%s, %s, NOW())", (data['id'], session['id'], ))
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SET sql_mode = ''")
	cur.execute("SELECT * FROM matcha.users_visits WHERE user_id = %s GROUP BY visit_id HAVING COUNT(*) >= 1", (data['id'], ))
	fame_rating_visit = cur.rowcount
	cur.execute("SELECT * FROM matcha.users_likes WHERE user_id = %s", (data['id'], ))
	fame_rating_like = cur.rowcount
	fame_rating = 0.0
	if fame_rating_visit != 0:
		fame_rating = round(fame_rating_like/fame_rating_visit, 2)
	cur.execute("UPDATE matcha.users SET fame_rating = ROUND(%s, 2) WHERE id = %s", (fame_rating, data['id'], ))
	temp_mydb.commit()
	cur.close()

	temp_mydb.close()

	return render_template('profile.html', fame_rating=fame_rating, data=data, pic=pic, basic=basic, age=age, appearance=appearance,
		lifestyle=lifestyle, background=background,
		description=description, city=city,
		country=country, district=district, interests=interests, my_interests=my_interests, likes=likes, mutual=mutual, photos=photos)

@app.route('/details', methods=['GET', 'POST'])
@is_logged_in
def details():
	
	cur = mydb.cursor(dictionary=True, buffered=True)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute("SELECT * FROM matcha.users WHERE id = %s", (session['id'], ))
	details = cur.fetchone()
	cur.close()

	return render_template('details.html', details=details)

@app.route('/save-account-info', methods=['GET', 'POST'])
def save_account_info():
	name = request.form['name']
	lastname = request.form['lastname']
	username = request.form['username']
	email = request.form['email']

	cur = mydb.cursor()
	query = "UPDATE matcha.users SET name = %s, last_name = %s, username = %s, email = %s WHERE id = %s"
	cur.execute(query, (name, lastname, username, email, session['id'], ))
	mydb.commit()
	cur.close()
	session.clear()
	flash('You are now logged out', 'success')
	return redirect(url_for('login'))

@app.route('/upload-profile-pic', methods=['GET', 'POST'])
def upload_profile_pic():
	file = request.files['file']
	if file and allowed_file(file.filename):
		filename = secure_filename(file.filename)
		newpath = r"static/uploads" + "/" + session['username'] + "/" + "profile_pic" + "/"
		file_path = newpath + "/" + filename
		if not os.path.exists(newpath):
			os.makedirs(newpath)

		file.save(os.path.join(newpath, filename))

		new_file_name = newpath + "cropped_" + filename

		im = Image.open(os.path.join(newpath, filename))
		width, height = im.size
		if width > height:
			crop(file_path, (200, 0, 1000, 800), new_file_name )
		else:
			crop(file_path, (00, 0, 600, 600), new_file_name )
		os.remove(file_path)

		cur = mydb.cursor()
		query = "UPDATE matcha.users_pictures SET profile_pic = %s WHERE user_id = %s"
		cur.execute(query, (new_file_name, session['id'], ))
		mydb.commit()
		cur.close()
		session['profile_pic'] = new_file_name
		return jsonify({'success' : 'Your profile pic has been set'})
	return jsonify({'error' : 'Ooopsie :( Something went wrong'})

@app.route('/dropzone', methods=['GET', 'POST'])
def dropzone():
	mydb = mysql.connector.connect(**config)

	new_uploads = 0
	for f in request.files.getlist('file'):
		new_uploads += 1

	cur = mydb.cursor(dictionary=True, buffered=True)
	query = "SELECT * FROM matcha.users_files_upload WHERE user_id = %s"
	cur.execute(query, (session['id'], ))
	already_uploaded = cur.rowcount
	cur.close()

	if new_uploads + already_uploaded > 4:
		return jsonify({'error' : 'You cannot upload more than 4 files to your gallery. You already have %s' % already_uploaded})
	
	if 'file' in request.files:
		newpath = r"static/uploads" + "/" + session['username'] + "/" + "awesome_pics" + "/"
		pics = []
		if not os.path.exists(newpath):
			os.makedirs(newpath)
		for f in request.files.getlist('file'):
			if allowed_file(f.filename):
				filename = secure_filename(f.filename)
				f.save(os.path.join(newpath, filename))

				new_file_name = newpath + filename
				pics.append((session['id'], str(new_file_name)))

		cur = mydb.cursor(buffered=True)
		query = "INSERT INTO matcha.users_files_upload (user_id, upload_pic) VALUES(%s, %s)"
		cur.executemany(query, pics)
		mydb.commit()
		cur.close()
		mydb.close()

		return jsonify({'success' : 'Your pictures have been uploaded'})
	return jsonify({'error' : 'Ooopsie :( Something went wrong'})

@app.route('/add_interests', methods=['GET', 'POST'])
def add_interests():

	temp_mydb = mysql.connector.connect(**config)


	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	query = "SELECT * FROM matcha.interests WHERE interest = %s"
	cur.execute(query, (request.form['tag'], ))
	result = cur.rowcount
	data = cur.fetchone()
	interest_id = data['id']

	query = "SELECT * FROM matcha.users_interests WHERE user_id = %s AND interest_id = %s"
	cur.execute(query, (session['id'], interest_id, ))
	entry_result = cur.rowcount

	if entry_result == 0:
		query = "INSERT INTO matcha.users_interests (user_id, interest_id) VALUES(%s, %s)"
		cur.execute(query, (session['id'], interest_id))
	temp_mydb.commit()
	cur.close()
	temp_mydb.close()

	return "OK"

@app.route('/remove_interests', methods=['GET', 'POST'])
def remove_interests():

	temp_mydb = mysql.connector.connect(**config)

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	query = "SELECT * FROM matcha.interests WHERE interest = %s"
	cur.execute(query, (request.form['tag'], ))
	result = cur.rowcount
	data = cur.fetchone()
	interest_id = data['id']

	query = "DELETE FROM matcha.users_interests WHERE user_id = %s AND interest_id = %s"
	cur.execute(query, (session['id'], interest_id))
	temp_mydb.commit()
	cur.close()
	temp_mydb.close()

	return "OK"

@app.route('/visit-history', methods=['GET', 'POST'])
def visit_history():
	cur = mydb.cursor(dictionary=True, buffered=True)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute('''SELECT *, DATE_FORMAT(visit_time, '%a, %H:%i') AS visit_time
					FROM matcha.users_visits WHERE user_id = %s
					AND visit_time BETWEEN (NOW() - INTERVAL 7 DAY) AND NOW()''', (session['id'], ))
	visits = cur.fetchall()
	cur.execute('''SELECT *, DATE_FORMAT(visit_time, '%a, %H:%i') AS visit_time FROM
				matcha.users_visits WHERE visit_id = %s
				AND visit_time BETWEEN (NOW() - INTERVAL 7 DAY) AND NOW()''', (session['id'], ))
	i_visited = cur.fetchall()
	cur.close()

	history = []
	my_history = []

	for visit in visits:
		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE id = %s", (visit['visit_id'], ))
		value = cur.fetchone()
		history.append((value['username'], visit['visit_time']))
		cur.close()

	for visit in i_visited:
		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE id = %s", (visit['user_id'], ))
		value = cur.fetchone()
		my_history.append((value['username'], visit['visit_time']))
		cur.close()

	return render_template("visit_history.html", visits=history, my_visits=my_history)

@app.route('/likes', methods=['GET', 'POST'])
def likes():
	cur = mydb.cursor(dictionary=True, buffered=True)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute('''SELECT *	FROM matcha.users_likes WHERE user_id = %s''', (session['id'], ))
	likes = cur.fetchall()

	recieved_likes = []
	my_likes = []

	for like in likes:
		cur = mydb.cursor(dictionary=True, buffered=True)
		cur.execute("SELECT * FROM matcha.users WHERE id = %s", (like['like_id'], ))
		value = cur.fetchone()
		recieved_likes.append((value['username'], ))
		cur.execute("SELECT * FROM matcha.users_likes WHERE user_id = %s AND like_id = %s", (like['like_id'], session['id'], ))
		mutual_like = cur.rowcount
		if mutual_like == 1:
			my_likes.append((value['username'], ))
		cur.close()

	return render_template("likes.html", recieved_likes=recieved_likes, my_likes=my_likes)

@app.route('/save-like', methods=['GET', 'POST'])
def save_like():
	temp_mydb = mysql.connector.connect(**config)

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users WHERE username = %s", (request.form['username'],))
	data = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (data['id'], ))
	settings = cur.fetchone()

	cur.execute("SELECT * FROM matcha.users_basic_info WHERE user_id = %s", (data['id'],))
	gender = cur.fetchone()
	cur.close()

	if data['id'] != session['id']:
		cur = temp_mydb.cursor(dictionary=True, buffered=True)
		cur.execute("INSERT INTO matcha.users_likes (user_id, like_id) VALUES (%s, %s)", (data['id'], session['id'], ))
		temp_mydb.commit()
		cur.close()
	temp_mydb.close()

	return jsonify({'success' : 'You got a new like!'})

@app.route('/delete-like', methods=['GET', 'POST'])
def delete_like():

	temp_mydb = mysql.connector.connect(**config)

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users WHERE username = %s", (request.form['username'],))
	data = cur.fetchone()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (data['id'], ))
	settings = cur.fetchone()
	cur.close()

	if data['id'] != session['id']:
		cur = temp_mydb.cursor(dictionary=True, buffered=True)
		cur.execute("DELETE FROM matcha.users_likes WHERE user_id = %s AND like_id = %s", (data['id'], session['id'], ))
		temp_mydb.commit()
		cur.close()
	temp_mydb.close()
	return jsonify({'success' : 'Someone disliked you :('})

@app.route('/report-user', methods=['GET', 'POST'])
def report_user():
	theme = "New user report"
	arguments = {
		"username_reporting" : session['username'],
		"username_reported" : request.form['username'],
	}

	app.logger.info(arguments)
	send_message(app, theme, "semkaway@gmail.com", 'report', mail, arguments)
	return jsonify({'success' : 'Your report will be reviewed by moderator as soon as possible. Thank you for your concern'})

@app.route('/block-user', methods=['GET', 'POST'])
def block_user():
	cur = mydb.cursor(buffered=True, dictionary=True)
	cur.execute("SELECT * FROM matcha.users WHERE username = %s", (request.form['username'],))
	data = cur.fetchone()
	cur.execute("SELECT * FROM matcha.users_blocked WHERE user_id = %s AND blocked_by_user_id = %s", (data['id'], session['id'], ))
	result = cur.rowcount
	if result == 0:
		cur.execute("INSERT INTO matcha.users_blocked (user_id, blocked_by_user_id) VALUES (%s, %s)", (data['id'], session['id'], ))
		mydb.commit()
	cur.close()
	return jsonify({'success' : 'This user has been blocked. This page will not appear in your search again'})

@app.route('/check-mutual', methods=['GET', 'POST'])
def check_mutual():
	temp_mydb = mysql.connector.connect(**config)
	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users WHERE username = %s", (request.form['username'], ))
	data = cur.fetchone()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (data['id'], ))
	settings = cur.fetchone()
	cur.close()

	cur = temp_mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users_likes WHERE user_id = %s AND like_id = %s", (session['id'], data['id'], ))
	likes = cur.rowcount
	if likes == 1:
		cur.execute("SELECT * FROM matcha.users_likes WHERE user_id = %s AND like_id = %s", (data['id'], session['id'], ))
		num_mutual = cur.rowcount
		if num_mutual == 1:
			if session['profile_pic'] != "static/img/default_profile.jpg":
				temp_mydb.commit()
			return jsonify({'value' : 'True'})
	cur.close()
	temp_mydb.close()
	return jsonify({'value' : 'False'})

@app.route('/chats', methods=['GET', 'POST'])
def chats_empty():
	cur = mydb.cursor(buffered=True, dictionary=True)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute('''SELECT matcha.users_likes.like_id FROM matcha.users_likes WHERE matcha.users_likes.user_id = %s''', (session['id'], ))
	users = cur.fetchall()
	cur.execute('''SELECT matcha.users_likes.user_id FROM matcha.users_likes WHERE matcha.users_likes.like_id = %s''', (session['id'], ))
	likes = cur.fetchall()
	cur.execute('''SELECT * FROM matcha.users_blocked WHERE user_id = %s OR blocked_by_user_id = %s''', (session['id'], session['id'], ))
	blocked = cur.fetchall()
	cur.execute('''SELECT * FROM matcha.users
					INNER JOIN matcha.users_pictures ON matcha.users_pictures.user_id=matcha.users.id
					INNER JOIN matcha.users_basic_info ON matcha.users_basic_info.user_id=matcha.users.id
					INNER JOIN matcha.users_location ON matcha.users_location.user_id=matcha.users.id''')
	profiles = cur.fetchall()
	for profile in profiles:
		profile['blocked'] = False

	for profile in profiles:
		for block in blocked:
			if profile['id'] == block['blocked_by_user_id'] or profile['id'] == block['user_id']:
				profile['blocked'] = True
	cur.close()
	return render_template("chats.html", users=users, messages="none", likes=likes, profiles=profiles)

@app.route('/chats/<person>', methods=['GET', 'POST'])
def chats(person):
	cur = mydb.cursor(buffered=True, dictionary=True)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute("SELECT * FROM matcha.users WHERE username = %s", (person, ))
	uid = cur.fetchone()
	cur.execute("SELECT * FROM matcha.users_likes WHERE (user_id = %s AND like_id = %s) OR (user_id = %s AND like_id = %s)", (uid['id'], session['id'], session['id'], uid['id'], ))
	num_mutual = cur.rowcount
	app.logger.info(num_mutual)
	cur.execute('''SELECT * FROM matcha.users_blocked WHERE (user_id = %s AND blocked_by_user_id = %s) OR (user_id = %s AND blocked_by_user_id = %s)''', (uid['id'], session['id'], session['id'], uid['id'], ))
	blocked = cur.rowcount
	app.logger.info(cur.rowcount)
	if num_mutual == 2 and blocked == 0:
		cur.execute("SELECT * FROM matcha.users")
		users = cur.fetchall()
		cur.execute("SELECT * FROM matcha.messages WHERE (sender_id = %s AND recipient_id = %s) OR (sender_id = %s AND recipient_id = %s)",
					(session['id'], uid['id'], uid['id'], session['id'], ))
		messages = cur.fetchall()
		cur.close()
		return render_template("chats.html", messages=messages, users=users)
	else:
		cur.close()
		return redirect(url_for("chats_empty"))

@app.route('/delete-pic', methods=['GET', 'POST'])
@is_logged_in
def delete_pic():
	app.logger.info(request.form)
	cur = mydb.cursor(dictionary=True, buffered=True)
	cur.execute("SELECT * FROM matcha.users WHERE username = %s", (request.form['username'], ))
	user_id = cur.fetchone()
	cur.execute("DELETE FROM matcha.users_files_upload WHERE user_id = %s AND upload_pic = %s", (user_id['id'], request.form['picture'], ))
	mydb.commit()
	cur.close()

	if os.path.exists(request.form['picture']):
		app.logger.info("pic exists")
		os.remove(request.form['picture'])
	return "OK"


@app.route('/delete-account', methods=['GET', 'POST'])
def delete_account():
	cur = mydb.cursor(buffered=True, dictionary=True)
	cur.execute("DELETE FROM matcha.users_visits WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_visits WHERE visit_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_pictures WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_location WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_likes WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_lifestyle WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_interests WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_files_upload WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_description WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_basic_info WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_appearance WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users_background WHERE user_id = %s", (session['id'], ))
	cur.execute("DELETE FROM matcha.users WHERE id = %s", (session['id'], ))
	mydb.commit()
	cur.close()

	newpath = r"static/uploads" + "/" + session['username']
	if os.path.exists(newpath):
		shutil.rmtree(newpath, ignore_errors=True)

	session.clear()

	return "OK"

@app.route('/delete-notification', methods=['GET', 'POST'])
def delete_notification():
	cur = mydb.cursor(buffered=True, dictionary=True)
	cur.execute("DELETE FROM matcha.notification_box WHERE current_user_id = %s AND message = %s", (request.form['current_user_id'], request.form['message'], ))
	mydb.commit()
	cur.close()
	return "OK"

@app.route('/settings')
@is_logged_in
def settings():
	cur = mydb.cursor(dictionary=True, buffered=True)

	cur.execute("SELECT * FROM matcha.notification_box WHERE current_user_id = %s", (session['id'],))
	notifications = cur.fetchall()

	session['notifications'] = notifications

	cur.execute("SELECT * FROM matcha.notifications WHERE user_id = %s", (session['id'], ))
	settings = cur.fetchone()
	cur.close()
	return render_template('settings.html', settings=settings)

@app.route('/save-settings', methods=['GET', 'POST'])
def save_settings():
	new_message = 1
	new_like = 1
	profile_check = 1
	mutual_like = 1
	unlike = 1

	if request.form['new_message'] == 'false':
		new_message = 0
	if request.form['new_like'] == 'false':
		new_like = 0
	if request.form['profile_check'] == 'false':
		profile_check = 0
	if request.form['new_connection'] == 'false':
		mutual_like = 0		
	if request.form['new_unlike'] == 'false':
		unlike = 0

	cur = mydb.cursor()
	cur.execute("UPDATE matcha.notifications SET message = %s, new_like = %s, unlike = %s, profile_check = %s, mutual_like = %s WHERE user_id = %s", 
				(new_message, new_like, unlike, profile_check, mutual_like, session['id'], ))
	mydb.commit()
	cur.close()
	return jsonify({'success' : 'Your changes have been saved'})

# USER PROFILE END

@app.errorhandler(404)
def page_not_found(e):
	return render_template('404.html'), 404

@app.errorhandler(403)
def forbidden(e):
	return render_template('403.html'), 403

@app.errorhandler(410)
def page_gone(e):
	return render_template('410.html'), 410

@app.errorhandler(500)
def server_error(e):
	return render_template('500.html'), 500

if __name__ == '__main__':
	socketio.run(app, debug=True)