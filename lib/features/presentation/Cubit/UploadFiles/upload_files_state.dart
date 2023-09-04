part of 'upload_files_cubit.dart';

abstract class UploadFilesState extends Equatable {
  const UploadFilesState();

  @override
  List<Object> get props => [];
}

class UploadFilesInitial extends UploadFilesState {}

class UploadFilesloading extends UploadFilesState {}
