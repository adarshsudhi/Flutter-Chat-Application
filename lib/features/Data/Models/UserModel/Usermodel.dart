// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';

class UserModel extends UserEntity {
  final String uid;
  final String name;
  final String emailaddress;
  final String date;
  final String profileurl;
  final int age;
  final String about;
  final String Devicetoken;
  final bool online;

  UserModel({
    required this.uid,
    required this.name,
    required this.emailaddress,
    required this.date,
    required this.profileurl,
    required this.age,
    required this.about,
    required this.Devicetoken,
    required this.online,
  }) : super(
                online: online,
                DeviceToken: Devicetoken,
                name: name,
                uid: uid,
                emailaddress: emailaddress,
                date: date,
                profileurl: profileurl,
                age: age,
                about: about);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'online':online,
      'uid': uid,
      'name': name,
      'emailaddress': emailaddress,
      'date': date,
      'profileurl': profileurl,
      'age': age,
      'about': about,
      'DeviceToken':Devicetoken
    };
  }

  static UserModel fromMap(QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
     online: map['online'] as bool,
      Devicetoken: map['DeviceToken'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      emailaddress: map['emailaddress'] as String,
      date: map['date'] as String,
      profileurl: map['profileurl'] as String,
      age: map['age'] as int,
      about: map['about'] as String,
    );
  }
}
