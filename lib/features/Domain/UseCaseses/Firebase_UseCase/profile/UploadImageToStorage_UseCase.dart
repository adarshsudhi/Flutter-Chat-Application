import 'dart:io';

import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class UploadImageUseCase {
  final FirebaseRepository repository;

  UploadImageUseCase(this.repository);

  Future<String> UploadImage(File file) async {
    return repository.UploadImagetostroage(file);
  }
}
