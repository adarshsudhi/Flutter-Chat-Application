// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/features/Domain/Entity/Chat/ChatEntity.dart';
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class SendMessageUseCase {
  final FirebaseRepository repository;
  SendMessageUseCase({
    required this.repository,
  });

  Future<void> send(ChatEntity entity) async {
    return repository.SendMessage(entity);
  }
}
