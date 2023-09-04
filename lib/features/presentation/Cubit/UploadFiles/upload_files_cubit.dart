import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Domain/UseCaseses/Firebase_UseCase/Chat/UploadAttachedFile_UseCase.dart';

part 'upload_files_state.dart';

class UploadFilesCubit extends Cubit<UploadFilesState> {
  final AttachedFileuploadUseCase attachedFileuploadUseCase;
  UploadFilesCubit({required this.attachedFileuploadUseCase})
      : super(UploadFilesInitial());

  Future<List<String>> Uploadattachedfile(
      List<XFile> file, String chatid) async {
    emit(UploadFilesloading());
    final response = await attachedFileuploadUseCase.Uploadfile(file, chatid);
    emit(UploadFilesInitial());
    return response;
  }
}
