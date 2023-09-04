// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String emailaddress;
  final String date;
  final String profileurl;
  final int age;
  final String about;
  final String DeviceToken;
  final bool online;

  UserEntity({
    required this.uid,
    required this.name,
    required this.emailaddress,
    required this.date,
    required this.profileurl,
    required this.age,
    required this.about,
    required this.DeviceToken,
    required this.online,
  });

  @override
  List<Object> get props {
    return [
      online,
      DeviceToken,
      name,
      uid,
      emailaddress,
      date,
      profileurl,about,age
    ];
  }
}
