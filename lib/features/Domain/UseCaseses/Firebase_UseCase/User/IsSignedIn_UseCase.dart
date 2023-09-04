import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class IsSignedInUseCase {
  final FirebaseRepository repository;

  IsSignedInUseCase(this.repository);
  Future<bool> IsSignedIn() {
    return repository.IsSignedIn();
  }
}
