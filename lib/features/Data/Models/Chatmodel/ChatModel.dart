// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_application/features/Domain/Entity/Chat/ChatEntity.dart';

class ChatModel extends ChatEntity {
  final String date;
  final String day;
  final String chatid;
  final String message;
  final String currentuser;
  final String url;
  final String frienduid;
  final bool read;
  final List<String> fileurl;
  final String Sendername;

  ChatModel({
    required this.date,
    required this.day,
    required this.chatid,
    required this.message,
    required this.currentuser,
    required this.url,
    required this.frienduid,
    required this.read,
    required this.fileurl,
    required this.Sendername,
  }) : super(
          SenderName: Sendername,
          fileurl: fileurl,
          day: day,
          read: read,
          frienduid: frienduid,
          url: url,
          date: date,
          chatid: chatid,
          message: message,
          currentuser: currentuser,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileurl': fileurl,
      'date': date,
      'day': day,
      'chatid': chatid,
      'message': message,
      'currentuser': currentuser,
      'url': url,
      'frienduid': frienduid,
      'read': read,
      'sendername': Sendername
    };
  }

  factory ChatModel.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return ChatModel(
      Sendername: map['sendername'] as String,
      fileurl: map['fileurl'] as List<String>,
      date: map['date'] as String,
      day: map['day'] as String,
      chatid: map['chatid'] as String,
      message: map['message'] as String,
      currentuser: map['currentuser'] as String,
      url: map['url'] as String,
      frienduid: map['frienduid'] as String,
      read: map['read'] as bool,
    );
  }
}
