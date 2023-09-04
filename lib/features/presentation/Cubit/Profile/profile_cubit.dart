import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/profile/GetProfile_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/profile/UploadprofileDetails_UseCase.dart';
import 'package:equatable/equatable.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UploadUserDetailsUseCase uploadUserDetailsUseCase;
  final GetProfileUseCase profileUseCase;
  ProfileCubit(this.uploadUserDetailsUseCase, this.profileUseCase)
      : super(ProfileInitial());

  Future<void> Upload(UserEntity enitity, File filee) async {
    emit(ProfileLoading());
    try {
      await uploadUserDetailsUseCase.UploadProfileDetails(enitity, filee);
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileFailed());
    }
  }

  Future<void> Get() async {
    emit(ProfileLoading());
    final enitity = await profileUseCase.GetProfile();
    if (enitity.isNotEmpty) {
      emit(Getprofile(enitity: enitity));
    } else {
      emit(ProfileFailed());
    }
  }
}
