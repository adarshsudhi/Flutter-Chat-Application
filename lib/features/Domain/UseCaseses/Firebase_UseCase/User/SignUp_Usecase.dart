import 'dart:io';

import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';

import '../../../Repository/Firebase_repository/Firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});
  Future<void> SignUp(UserEntity user, String password,File file) {
    return repository.SignUpuser(user, password,file);
  }
}
