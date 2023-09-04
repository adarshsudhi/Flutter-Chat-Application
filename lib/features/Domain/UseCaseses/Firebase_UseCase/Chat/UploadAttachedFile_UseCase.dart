import 'dart:async';
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';
import 'package:image_picker/image_picker.dart';

class AttachedFileuploadUseCase {
  final FirebaseRepository repository;
  AttachedFileuploadUseCase({
    required this.repository,
  });
  Future<List<String>> Uploadfile(List<XFile> file, String chatid) {
    return repository.Uploadattachedfile(file, chatid);
  }
}
