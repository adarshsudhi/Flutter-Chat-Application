import 'dart:io';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import '../../../Repository/Firebase_repository/Firebase_repository.dart';

class UploadUserDetailsUseCase {
  final FirebaseRepository repository;

  UploadUserDetailsUseCase(this.repository);

  Future<void> UploadProfileDetails(UserEntity enitity, File filee) async {
    return repository.UploadUserdetails(enitity, filee);
  }
}
