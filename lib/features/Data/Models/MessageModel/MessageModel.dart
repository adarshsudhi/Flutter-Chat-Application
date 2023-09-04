// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Domain/Entity/Message/MessageEntity.dart';

class Messagemodel extends MessageEntity {
  final String profileurl;
  final String unreadmessages;
  final String name;
  final String Date;
  final String currentuseruid;
  final String frienduid;
  final String chatid;
  final String Senderid;
  final String lastmessage;
  final bool online;
  Messagemodel({
    required this.profileurl,
    required this.unreadmessages,
    required this.name,
    required this.Date,
    required this.currentuseruid,
    required this.frienduid,
    required this.chatid,
    required this.Senderid,
    required this.lastmessage,
    required this.online,
  }) : super(
    online: online,
              Senderid: Senderid,
              lastmessage: lastmessage,
              frienduid: frienduid,
              chatid: chatid,
              currentuseruid: currentuseruid,
              profileurl: profileurl,
              unreadmessages: unreadmessages,
              name: name,
              date: Date);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'online':online,
      'senderid': Senderid,
      'lastmessage': lastmessage,
      'chatid': chatid,
      'currentuseruid': currentuseruid,
      'frienduid': frienduid,
      'profileurl': profileurl,
      'unreadmessages': unreadmessages,
      'name': name,
      'Date': Date,
    };
  }

  factory Messagemodel.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return Messagemodel(
      online: map['online'] as bool,
      Senderid: map['senderid'] as String,
      lastmessage: map['lastmessage'] as String,
      frienduid: map['frienduid'] as String,
      chatid: map['chatid'] as String,
      currentuseruid: map['currentuseruid'] as String,
      profileurl: map['profileurl'] as String,
      unreadmessages: map['unreadmessages'] as String,
      name: map['name'] as String,
      Date: map['Date'] as String,
    );
  }
}
