'''
author: Reynolds Okyere Boakye
title: ashesiConnect API
'''

import json
from flask import Flask, request, jsonify, escape
import functions_framework
import firebase_admin
from firebase_admin import credentials, firestore
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.image import MIMEImage

# connect to firebase
app = firebase_admin.initialize_app()
db = firestore.client()

# main running function to be deployed
@functions_framework.http
def services(request):
    if request.path == '/':
        if request.method == 'GET':
            return view_profile(request)
        elif request.method == 'POST':
            return create_profile(request)
        else:
            from flask import abort
            return abort(405)
        
    elif request.path == '/post':
        if request.method == 'GET':
            return get_posts(request)
        elif request.method == 'POST':
            return make_post(request) 
        else:
            from flask import abort
            return abort(405)
            
    elif request.path == '/editUser' and request.method == 'POST':
        return edit_profile(request)
            
    else:
        from flask import abort
        return abort(405)

# view a sudent's record
def view_profile(request):   
    request_json = request.get_json(silent=True)
    request_args = request.args
    
    if request_args and 'id' in request_args:
        student_id = request_args['id']
    elif request_json and 'id' in request_json:
        student_id = request_json['id']
    else:
        response = jsonify({"Response":'Specify ID'})
        response.headers['Content-Type'] = 'application/json'
        return response,404
        
    student_ref = db.collection('profiles')
    students = student_ref.stream()    
    
    for student in students:
        result = student.to_dict()
        if result['id'] == student_id:
            response = jsonify(result)
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Content-Type'] = 'application/json'
            return response, 200
            
    response = jsonify({"Response":'No student with this ID found'})
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = 'application/json'
    return response,404


#create a new student's profile
def create_profile(request):
    request_json = json.loads(request.data)
    
    if request_json and 'id' in request_json and 'email' in request_json:
        student_id = request_json['id']
        email = request_json['email']
    else:
        response = jsonify({"Response": 'Specify ID'})
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Content-Type'] = 'application/json'
        return response, 404
    
    student_ref = db.collection('profiles')
    students = student_ref.stream()   

    for student in students:
        if student.to_dict()['id'] == student_id:
            response = jsonify({"Response":student_id+" already exists"})
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Content-Type'] = 'application/json'
            return response,409
    
    student_ref = student_ref.document(str(student_id))
    student_ref.set(request_json)  
    
    # update email list
    emails = db.collection('emails').document('all_emails')
    emails.update({'emails': firestore.ArrayUnion([email])})
        
    response = jsonify({"Response":student_id + "'s record is added"})
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = 'application/json'
    return response, 201
    

#update an existing student's profile
def edit_profile(request):
    request_json = json.loads(request.data)

    if request_json and 'id' in request_json:
        student_id = request_json['id']
    else:
        response = jsonify({"Response": 'Specify ID'})
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Content-Type'] = 'application/json'
        return response, 404
        
    students_ref = db.collection('profiles')
    students = students_ref.stream()    
    
    for student in students:
        result = student.to_dict()
        if result['id'] == student_id:
            update = students_ref.document(student_id)
            # make the necessary changes only in the different information
            for key, value in request_json.items():                
                if key not in result or value != result[key]:
                    update.update({key:value})
            
            response = jsonify({"Response": student_id+"'s record is updated"})
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Content-Type'] = 'application/json'
            return response
             
    return jsonify({"Response": str(student_id) + "not found"}),404


# POSTS
# get all posts
def get_posts(request):         
    posts_ref = db.collection('posts')
    posts = posts_ref.order_by('timestamp', direction=firestore.Query.DESCENDING)
    results = posts.stream()
    
    all_posts = {}
    for num, each in enumerate(results):
        all_posts[num] = each.to_dict()

    if all_posts: 
        response = jsonify(all_posts)
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Content-Type'] = 'application/json'
        return response
            
    else:
        response = jsonify({"Response":"No post yet"})
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Content-Type'] = 'application/json'
        return response,404
    

# create post
def make_post(request):   
    request_json = json.loads(request.data)
    
    if request_json and ('id' in request_json and 'email' in request_json  and 'text' in request_json):
        student_id = request_json['id']
        student_email = request_json['email']
        student_text = request_json['text']
        
        request_json['timestamp'] = firestore.SERVER_TIMESTAMP
        post_ref = db.collection('posts').add(request_json)  
        
        emails_ref = db.collection('emails').document('all_emails')
        emails = emails_ref.get().to_dict()

        iscomplete = send_email(emails['emails'], student_email, student_text)

        if iscomplete:
            response = jsonify({"Response":"Post Added"}) 
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Content-Type'] = 'application/json'
            return response, 200
        else:
            response = jsonify({"Response":"Encountered error while sending email"})
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Content-Type'] = 'application/json'
            return response, 404
            
    else:
        response = jsonify({"Response":'Specify ID and Email and Text'})
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Content-Type'] = 'application/json'
        return response, 404


# email factory
def send_email(emails, name, text):       
    # Set up the SMTP server details
    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    smtp_username = "ashesiconnect@gmail.com"
    smtp_password = "lgcyxuvqbayccxlf"
    
    # Set up the message parameters
    sender = "ashesiconnect@gmail.com"
    recipients = emails
    subject = name + " just posted on AshesiConnect"
    body = text
    
    # Create the email message object
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = ", ".join(recipients)
    msg['Subject'] = subject
    
    # Add the message body to the email message object
    msg.attach(MIMEText(body, 'plain'))
    
    # Attach an image to the email message object (optional)
    try:
        with open("connect.png", "rb") as f:
            img = MIMEImage(f.read())
            msg.attach(img)
        
        # Connect to the SMTP server and send the email
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls()
            server.login(smtp_username, smtp_password)
            server.sendmail(sender, recipients, msg.as_string())
            
        return True
        
    except:
        return False
    
# https://us-central1-student-services-383506.cloudfunctions.net/services