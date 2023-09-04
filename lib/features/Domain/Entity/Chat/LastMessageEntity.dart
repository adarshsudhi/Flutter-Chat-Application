// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LastMessageEntity extends Equatable {
  final String senderid;
  final String message;
  LastMessageEntity({
    required this.senderid,
    required this.message,
  });

  @override
  List<Object> get props => [senderid, message];
}
