import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetHomeUserUseCase {
  final FirebaseRepository repository;
  GetHomeUserUseCase({
    required this.repository,
  });
  Stream<QuerySnapshot<Map<String, dynamic>>> Gethomeuser() {
    return repository.GetHomeuser();
  }
}
