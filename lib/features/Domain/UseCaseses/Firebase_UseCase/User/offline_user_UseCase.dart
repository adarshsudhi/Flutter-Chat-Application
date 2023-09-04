// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class offineUserUsaeCase {
  final FirebaseRepository repository;
  offineUserUsaeCase({
    required this.repository,
  });
  Future<void>call(String uid)async{
    return repository.setoffline(uid);
  }
}
