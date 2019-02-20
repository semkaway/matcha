from flask import render_template
from flask_mail import Message
from decorators import async

def validate_email(email):
	dot = email.find('.')
	if dot == -1:
		return False
	return True

def validate_password(password):
	if any(char.isdigit() for char in password) == False:
		return False
	if any(char.isupper() for char in password) == False:
		return False
	return True

def confirm_password(password, confirm):
	if password != confirm:
		return False
	return True

@async
def send_async_email(app, msg, mail):
    with app.app_context():
        mail.send(msg)

# def send_email(subject, sender, recipients, text_body, html_body):
#     msg = Message(subject, sender = sender, recipients = recipients)
#     msg.body = text_body
#     msg.html = html_body
#     send_async_email(msg)

def send_message(app, theme, email, body, mail, arguments):
	msg = Message(theme,
              sender="kvilna@student.unit.ua",
              recipients=[email])
	msg.body=render_template(body+'.txt', arguments=arguments)
	msg.html=render_template(body+'.html', arguments=arguments)
	send_async_email(app, msg, mail)