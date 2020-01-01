from .. import app
import datetime
from flask import render_template, request, jsonify, redirect, url_for, session,send_from_directory
from .backend import userCol,requestCol,postCol
from bson.objectid import ObjectId
import bcrypt
import random
import os

ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/getMatch',methods=['GET'])
def iostest():
    user = None
    if 'NTOUmotoGoUser' in session and 'NTOUmotoGoToken' in session:
        user = userCol.find_one({'Account_name' : session['NTOUmotoGoUser']})
    if user:
        matchHistory = user['_matchHistory']
        results = []
        for requestId in matchHistory:
            tmp = requestCol.find_one({'_id':ObjectId(requestId)})
            sender = userCol.find_one({'_id' : tmp['sender_id']})
            Post = postCol.find_one({'_id' : ObjectId(tmp['post_id'])})
            if tmp['_state'] == 'matched':
                result = {'getOnTime':Post['post_getOnTime'].isoformat(),
                          'post_location':Post['post_location'],
                          'post_goto':Post['post_goto'],
                          'post_notice':Post['post_notice'],
                          'sender_name':sender['_name'],
                          'id':str(requestId)
                          }
                if user['_id'] == tmp['pas_id']: #設定map要看的目標
                    result.update({'target_id':str(tmp['dri_id'])})
                if user['_id'] == tmp['dri_id']: #設定map要看的目標
                    result.update({'target_id':str(tmp['pas_id'])})
                results.append(result)
        return jsonify(results)

    return jsonify({'stste':False})

    #使用者登入
@app.route('/iosLogin',methods=['GET','POST'])
def iosLogin():
    user = request.get_json(silent=True)
    login_user = userCol.find_one({'Account_name' : user['Account_name']})
    if login_user:
        if bcrypt.hashpw(user['_password'].encode('utf-8'), login_user['_password'].encode('utf-8')) == login_user['_password'].encode('utf-8'):#密碼解碼 核對密碼 找時間嘗試
            #socketio.emit('socketlogout',room = login_user['Account_name']) #把以前的用戶登出
            token = login_user['_token']
            while token is login_user['_token']:
                token = random.random()
            userCol.update({'_id' : login_user['_id']}, {"$set": {'_token' : token, '_lastLogin' : datetime.datetime.now()}}) #修改登入時間，登入狀態
            session['NTOUmotoGoUser'] = login_user['Account_name'] #建立session
            session['NTOUmotoGoToken'] = token
            session.permanent = True #設定session時效
            return jsonify({"state": True})
        return jsonify({"state":False})
    else:
        return jsonify({"state":False})

@app.route('/iosReturnLocation',methods=['GET','POST'])
def iosReturnLocation():
    tmp = request.values.to_dict()
    other_id = tmp['id']
    # user = userCol.find_one({'Account_name' : session['NTOUmotoGoUser']})
    # other_pos = {'other_lat': user['_lastLocation']['lat'], 'other_lng': user['_lastLocation']['lng']}
    if other_id and len(other_id) == 24:
        other_user = userCol.find_one({'_id' : ObjectId(other_id)})
        if other_user:
            other_pos = {'lat': other_user['_lastLocation']['lat'], 'lng': other_user['_lastLocation']['lng']}
    return jsonify(other_pos)

@app.route('/iosGetUserPic',methods=['GET','POST'])
def iosGetUserPic():
    tmp = request.values.to_dict()
    other_id = tmp['id']
    if other_id and len(other_id) == 24:
        other_user = userCol.find_one({'_id' : ObjectId(other_id)})
        if other_user:
            return app.send_static_file("userPhotos/"+other_user['_user_photo'])
    return "wrong"

@app.route('/iosGetMyPic',methods=['GET','POST'])
def iosGetMyPic():
    if 'NTOUmotoGoUser' in session:
        user = userCol.find_one({'Account_name' : session['NTOUmotoGoUser']})
        if user:
            return app.send_static_file("userPhotos/"+user['_user_photo'])
    return "wrong"

@app.route('/iosUploadPic',methods=['GET','POST'])
def iosUploadPic():
    if 'NTOUmotoGoUser' in session:
        user = userCol.find_one({'Account_name' : session['NTOUmotoGoUser']})
        if '_user_photo' in request.files:
            file = request.files['_user_photo']
            if file and allowed_file(file.filename):
                if not os.path.isdir(app.config['UPLOAD_FOLDER']+'/'+user['Account_name']):
                    os.mkdir(app.config['UPLOAD_FOLDER']+'/'+user['Account_name'])
                num_files = 0
                for fn in os.listdir(app.config['UPLOAD_FOLDER']+'/'+user['Account_name']):
                    num_files += 1
                file.save(os.path.join(app.config['UPLOAD_FOLDER']+'/'+user['Account_name'], str(num_files)+"_user_photo.jpg"))
                userCol.update_one({'_id':user['_id']},{'$set':{'_user_photo' : user['Account_name']+'/'+str(num_files)+"_user_photo.jpg"}})
                print("uploaded")
    return "wrong"