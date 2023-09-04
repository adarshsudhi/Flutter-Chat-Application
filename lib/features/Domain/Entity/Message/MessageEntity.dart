// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String profileurl;
  final String unreadmessages;
  final String name;
  final String date;
  final String chatid;
  final String currentuseruid;
  final String frienduid;
  final String lastmessage;
  final String Senderid;
  final bool online;

  MessageEntity({
    required this.profileurl,
    required this.unreadmessages,
    required this.name,
    required this.date,
    required this.chatid,
    required this.currentuseruid,
    required this.frienduid,
    required this.lastmessage,
    required this.Senderid,
    required this.online,
  });

  @override
  List<Object> get props => [
        online,
        Senderid,
        lastmessage,
        profileurl,
        unreadmessages,
        name,
        date,
        chatid,
        currentuseruid,
        frienduid
      ];
}
