import 'package:chat_application/features/Domain/Entity/Chat/LastMessageEntity.dart';

class LastMessageModel extends LastMessageEntity {
  final String senderid;
  final String message;
  LastMessageModel({
    required this.senderid,
    required this.message,
  }) : super(senderid: senderid, message: message);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderid': senderid,
      'lastmessage': message,
    };
  }

  factory LastMessageModel.fromMap(Map<String, dynamic> map) {
    return LastMessageModel(
      senderid: map['senderid'] as String,
      message: map['lastmessage'] as String,
    );
  }
}
