import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';

import '../../../Repository/Firebase_repository/Firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});
  Future<void> Signin(UserEntity user, String password) {
    return repository.SignInuser(user, password);
  }
}
