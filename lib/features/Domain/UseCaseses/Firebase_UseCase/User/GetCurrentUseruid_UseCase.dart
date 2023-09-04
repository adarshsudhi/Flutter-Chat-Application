import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class GetCurrentUserUIDUseCase {
  final FirebaseRepository repository;

  GetCurrentUserUIDUseCase({required this.repository});

  Future<String> GetUID() {
    return repository.GetCurrentUserUid();
  }
}
