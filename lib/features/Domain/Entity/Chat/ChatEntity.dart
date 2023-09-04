// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String date;
  final String chatid;
  final String message;
  final String currentuser;
  final String url;
  final String frienduid;
  final bool read;
  final String day;
  final List<String> fileurl;
  final String SenderName;

  ChatEntity({
    required this.date,
    required this.chatid,
    required this.message,
    required this.currentuser,
    required this.url,
    required this.frienduid,
    required this.read,
    required this.day,
    required this.fileurl,
    required this.SenderName,
  });

  @override
  List<Object> get props {
    return [
      SenderName,
      fileurl,
      day,
      read,
      frienduid,
      url,
      date,
      chatid,
      message,
      currentuser,
    ];
  }
}
