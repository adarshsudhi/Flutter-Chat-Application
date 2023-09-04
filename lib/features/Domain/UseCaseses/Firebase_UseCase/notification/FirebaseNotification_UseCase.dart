import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class FirebaseNotification {
   final FirebaseRepository repository;
  FirebaseNotification({
    required this.repository,
  });
  Future<void>call()async{
    return repository.InitializeNotification();
  }
}
