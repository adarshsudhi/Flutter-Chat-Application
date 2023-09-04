// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class ReadUnreadMessagesUseCase {
  final FirebaseRepository repository;
  ReadUnreadMessagesUseCase({
    required this.repository,
  });
  Future<void> call(String Chatid, String Currentuseruid) async {
    return repository.readUnreadmessages(Chatid, Currentuseruid);
  }
}
