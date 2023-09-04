
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class GetchatsUseCase {
  final FirebaseRepository repository;
  GetchatsUseCase({
    required this.repository,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> call(String Chatid) {
    return repository.Getchats(Chatid);
  }
}
