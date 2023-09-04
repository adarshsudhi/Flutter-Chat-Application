import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chat_application/features/presentation/pages/Home/Homescreen.dart';
import 'package:chat_application/features/presentation/pages/Search/Search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:chat_application/features/Data/DataSource/RemoteDataSource/RemoteDataSource.dart';
import 'package:chat_application/features/Data/Models/Chatmodel/ChatModel.dart';
import 'package:chat_application/features/Data/Models/MessageModel/MessageModel.dart';
import 'package:chat_application/features/Data/Models/UserModel/Usermodel.dart';
import 'package:chat_application/features/Domain/Entity/Chat/ChatEntity.dart';
import 'package:chat_application/features/Domain/Entity/Chat/LastMessageEntity.dart';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import '../../../../config/constants/constants.dart';

class FirebaseRemoteSourceimpl implements RemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  FirebaseRemoteSourceimpl({
    required this.firestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<String> GetCurrentUserUid() async {
    String uid = firebaseAuth.currentUser!.uid;
    return uid;
  }

  @override
  Future<bool> IsSignedIn() async {
    if (firebaseAuth.currentUser?.uid == null) {
      return false;
    } else {
      return true;
    }
  }



  @override
  Future<void> SignInuser(UserEntity user, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: user.emailaddress, password: password)
          .then((value) {
        Showtoast("Welcome");
      });
    } catch (e) {
      Showtoast(e.toString().replaceRange(0, 15, ""));
    }
  }

  @override
  Future<void> SignUpuser(UserEntity user, String password, File file) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.emailaddress, password: password)
          .then((value) async {
        if (value.user != null) {
          final uid = await GetCurrentUserUid();
          final url = await UploadImagetostroage(file);
          await firestore.collection('users').doc(uid).set(UserModel(
                online: true,
                Devicetoken: user.DeviceToken,
                age: user.age,
                about: user.about,
                profileurl: url,
                name: user.name,
                uid: uid,
                emailaddress: user.emailaddress,
                date: DateTime.now().toString(),
              ).toMap());
          Showtoast("Account Created Succesfully");
        } else {
          Showtoast("Error Occuured While Creating the user");
        }
      });
    } catch (e) {
      Showtoast(e.toString().replaceRange(0, 20, ''));
    }
  }

  @override
  Future<void> SignOutuser() async {
    try {
      await firebaseAuth.signOut();
      Showtoast("Sign Out Successfull");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<String> UploadImagetostroage(File file) async {
    final uid = await GetCurrentUserUid();
    final Data = await firebaseStorage.ref().child(uid).child("Pic");
    UploadTask task = Data.putFile(file);
    TaskSnapshot snapshot = await task;
    String URL = await snapshot.ref.getDownloadURL();
    return URL;
  }

  @override
  Future<void> UploadUserdetails(UserEntity enitity, File filee) async {
    try {
      final uid = await GetCurrentUserUid();

      final String URL = await UploadImagetostroage(filee);
      await firestore
          .collection('users')
          .doc(uid).update({
            'age':enitity.age,
            'about':enitity.about,
            'name':enitity.name,
            'profileurl':URL
          });
          
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<List<UserEntity>> GetProfile() async {
    List<UserEntity> details = [];
    final String uid = await GetCurrentUserUid();

    final user =
        await firestore.collection('users').where('uid', isEqualTo: uid).get();

    user.docs.forEach((element) {
      details.add(UserModel.fromMap(element));
    });

    return details;
  }

  @override
  Future<void> SendMessage(ChatEntity chatEntity) async {
    try {
   
      final path = firestore
          .collection('users')
          .doc(chatEntity.currentuser)
          .collection('Homeusers');
     
      final currentuser = await GetaSingleUser(chatEntity.frienduid);
      final frienduser = await GetaSingleUser(chatEntity.currentuser);

      await firestore
          .collection('UserChats')
          .doc(chatEntity.chatid)
          .collection('chats')
          .doc()
          .set(ChatModel(
            Sendername: chatEntity.SenderName,
            fileurl: chatEntity.fileurl,
            day: chatEntity.day,
            read: false,
            frienduid: chatEntity.frienduid,
            url: chatEntity.url,
            date: chatEntity.date,
            chatid: chatEntity.chatid,
            message: chatEntity.message,
            currentuser: chatEntity.currentuser,
          ).toMap()).then((value) async{
            if (currentuser[0].online == false) {
               await SendNotification(chatEntity.message,chatEntity.SenderName, currentuser[0].DeviceToken.toString());
            }                  
          });
         
    QuerySnapshot<Map<String, dynamic>> frienduserexist = await firestore
          .collection('users')
          .doc(chatEntity.frienduid)
          .collection("Homeusers")
          .where('chatid', isEqualTo: chatEntity.chatid)
          .get();

      final Existinguser =
          await path.where('chatid', isEqualTo: chatEntity.chatid).get();

      if (frienduserexist.docs.isEmpty && Existinguser.docs.isEmpty) {
        await UpdateHomeuser(currentuser, frienduser, chatEntity);
      } else {}

      final count =
          await Getunreadmessages(chatEntity.chatid, chatEntity.frienduid);

      final frienddocid = frienduserexist.docs.first.id;
      final currentuserdocid = Existinguser.docs.first.id;

      await UpdatelastRecieved(chatEntity, currentuserdocid, frienddocid);

      if (count != '0') {
        final update = await firestore
            .collection('users')
            .doc(chatEntity.frienduid)
            .collection('Homeusers')
            .where('frienduid', isEqualTo: chatEntity.currentuser)
            .limit(1)
            .get();

        final data = update.docs.first;
        String id = data.id;
        await firestore
            .collection('users')
            .doc(chatEntity.frienduid)
            .collection('Homeusers')
            .doc(id)
            .update({"unreadmessages": count.toString()});
      }
    } catch (e) {}
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> Getchats(String Chatid) {
    final documents = firestore
        .collection('UserChats')
        .doc(Chatid)
        .collection('chats')
        .orderBy('date', descending: false);

    final res = documents.snapshots();
    return res;
  }

  @override
  Future<List<UserEntity>> GetaSingleUser(String UID) async {
    final List<UserEntity> profiles = [];
    final profile = await firestore
        .collection('users')
        .where('uid', isEqualTo: UID)
        .limit(1)
        .get();

    profile.docs.forEach((element) {
      profiles.add(UserModel.fromMap(element));
    });

    return profiles;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> GetHomeuser() {
    final homeusers = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('Homeusers').orderBy('Date');

    return homeusers.snapshots();
  }

  @override
  Stream<List<UserEntity>> SearchUser(String name) {
    final search = firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: name)
        .limit(3);
    return search
        .snapshots()
        .map((event) => event.docs.map((e) => UserModel.fromMap(e)).toList());
  }

  @override
  Future<int> Getunreadmessages(String Chatid, String friendid) async {
    List<bool> count = [];

    final details = await firestore
        .collection('UserChats')
        .doc(Chatid)
        .collection('chats')
        .where('frienduid', isEqualTo: friendid)
        .get();

    for (var element in details.docs) {
      if ((element.data() as dynamic)['read'] == false) {
        count.add((element.data() as dynamic)['read']);
      }
    }

    if (count.isNotEmpty) {
      return count.length;
    }
    return 0;
  }

  @override
  Future<LastMessageEntity> GetlastRecievedMEssage(String uid) async {
    final documents = await firestore
        .collection('UserChats')
        .doc(uid)
        .collection('chats')
        .orderBy('date', descending: true)
        .limit(1)
        .get();

    LastMessageEntity entity = LastMessageEntity(
        senderid: documents.docs[0]['currentuser'],
        message: documents.docs[0]['message']);

    return entity;
  }

  @override
  Future<void> UpdateHomeuser(List<UserEntity> currentuser,
      List<UserEntity> Frienduser, ChatEntity chatEntity) async {
    final len1 = await firestore
        .collection('users')
        .doc(chatEntity.frienduid)
        .collection('Homeusers')
        .get();

    final len = await firestore
        .collection('users')
        .doc(chatEntity.currentuser)
        .collection('Homeusers')
        .get();

    await firestore
        .collection('users')
        .doc(chatEntity.frienduid)
        .collection('Homeusers')
        .doc('user${len1.docs.length}')
        .set(Messagemodel(
                online: true,
                Senderid: '',
                lastmessage: '',
                profileurl: Frienduser[0].profileurl,
                unreadmessages: '',
                name: Frienduser[0].name,
                Date: Frienduser[0].date,
                currentuseruid: chatEntity.frienduid,
                frienduid: Frienduser[0].uid,
                chatid: chatEntity.chatid)
            .toMap());

    await firestore
        .collection('users')
        .doc(chatEntity.currentuser)
        .collection("Homeusers")
        .doc('user${len.docs.length}')
        .set(Messagemodel(
                online: true,
                Senderid: '',
                lastmessage: '',
                profileurl: currentuser[0].profileurl,
                unreadmessages: '',
                name: currentuser[0].name,
                Date: currentuser[0].date,
                currentuseruid: chatEntity.currentuser,
                frienduid: currentuser[0].uid,
                chatid: chatEntity.chatid)
            .toMap());
  }

  @override
  Future<List<String>> Uploadattachedfile(
      List<XFile> file, String Chatid) async {
    List<String> ImageURLS = [];
    final data = await firebaseStorage.ref().child(Chatid).listAll();

    for (var a = 0; a < file.length; a++) {
      UploadTask upload = firebaseStorage
          .ref()
          .child(Chatid)
          .child('file${data.items.length}')
          .putFile(File(file[a].path));
      TaskSnapshot snapshot = await upload;
      String URL = await snapshot.ref.getDownloadURL();
      ImageURLS.add(URL);
    }
    return ImageURLS;
  }

  @override
  Future<void> UpdatelastRecieved(ChatEntity chatEntity,
      String Currentuserdocid, String Frienduserdocid) async {
    final lastmessage = await GetlastRecievedMEssage(chatEntity.chatid);

    await firestore
        .collection('users')
        .doc(chatEntity.frienduid)
        .collection("Homeusers")
        .doc(Frienduserdocid)
        .update({
      'senderid': lastmessage.senderid.toString(),
      'lastmessage': lastmessage.message.toString()
    });

    await firestore
        .collection('users')
        .doc(chatEntity.currentuser)
        .collection('Homeusers')
        .doc(Currentuserdocid)
        .update({
      'senderid': lastmessage.senderid.toString(),
      'lastmessage': lastmessage.message.toString()
    });
  }

  @override
  Future<void> readUnreadmessages(String Chatid, String Currentuseruid) async {
    final data = await firestore
        .collection('UserChats')
        .doc(Chatid)
        .collection('chats')
        .where('frienduid', isEqualTo: Currentuseruid)
        .get();

    final update = await firestore
        .collection('users')
        .doc(Currentuseruid)
        .collection('Homeusers')
        .get();

    for (var docs in update.docs) {
      if ((docs.data() as dynamic)['chatid'] == Chatid) {
        docs.reference.update({'unreadmessages': ''});
      }
    }
    for (var element in data.docs) {
      element.reference.update({'read': true});
    }
  }

  
  @override
  Future<void> InitializeNotification() async{
     FirebaseMessaging _messageing = FirebaseMessaging.instance;
     String? DeviceToken  = await _messageing.getToken();
  if (DeviceToken != null) {
   await _messageing.requestPermission(alert: true,announcement: true,sound: true,criticalAlert: true,badge: true,carPlay: true);  
     String? uid = await GetCurrentUserUid();
     if (uid.isNotEmpty) {
        DocumentSnapshot<Map<String,dynamic>> data =  await firestore.collection('users').doc(uid).get();
   if (data['DeviceToken'] != DeviceToken) {
     await firestore.collection('users').doc(uid).update({'DeviceToken':DeviceToken});
   }
     }
  }}
  
  @override
  Future<void> SendNotification(String content,String UserName,String FCM)async {
    var bodydata = {
      'to': FCM,
      'priority':'high',
      'data':{
        "call_sender_id": firebaseAuth.currentUser!.uid,
        'title':UserName,
        'body':content
         }
    };
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),body: jsonEncode(bodydata),headers: {
      'Content-Type':'application/json; charset=UTF-8',
      'Authorization': "key=$ServerKey",
    });
  } 
  
  @override
  Future<void> SendCallNofication(String content,String UserName,String FCM,String type) async{
   var bodydata = {
      'to': FCM,
      'priority':'high',
      'data':{
        "call_type": type,
        "call_sender_id": firebaseAuth.currentUser!.uid,
        'token':content,
        'channelname':UserName,
        'screen':Searchuser.SearchScreen,
         }
    };
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),body: jsonEncode(bodydata),headers: {
      'Content-Type':'application/json; charset=UTF-8',
      'Authorization': "key=$ServerKey",
    });
  }
  
  @override
  Future<String> GenerateTempToken(String channelname,String uid) async{
    try {
     final String url = Endpoint(channelname,uid);
     final http.Response response =  await http.get(Uri.parse(url));
     if (response.statusCode == 200) {
        Map<String,dynamic> token = jsonDecode(response.body);
        return token['rtcToken'];
     } else {
        print(response.statusCode);
        return 'Error';
     }
    } catch (e) {
      return e.toString();
    }
  }
  
  @override
  Future<void> SetOnline(String uid)async{
   try {
     String baseURL = "http://192.168.18.49:3000/online/$uid";
     await http.put(Uri.parse(baseURL),headers: {
      'Content-Type':'application/json; charset=UTF-8',
     });
   } catch (e) {
      print(e.toString());;
   }
  }
  
  @override
  Future<void> setoffline(String uid)async {
     try {
     String baseURL = "http://192.168.18.49:3000/offline/$uid";
     await http.put(Uri.parse(baseURL),headers: {
      'Content-Type':'application/json; charset=UTF-8',
     });
   } catch (e) {
      print(e.toString());;
   }
  }  
  

}
