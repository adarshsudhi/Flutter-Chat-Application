import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

import '../../../Entity/User/user_entity.dart';

class GetProfileUseCase {
  final FirebaseRepository repository;

  GetProfileUseCase(this.repository);
  Future<List<UserEntity>> GetProfile() {
    return repository.GetProfile();
  }
}
