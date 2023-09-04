import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class SignOutUsceCase {
  final FirebaseRepository repository;

  SignOutUsceCase(this.repository);

  Future<void> SignOutuser() {
    return repository.SignOutuser();
  }
}
