import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SignIn_Usecase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SignOutUser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SignUp_Usecase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/notification/FirebaseNotification_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/Notification_UseCase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final FirebaseNotification firebaseNotification;
  final SignOutUsceCase signOutUsceCase;
  final NotificationUseCase notificationUseCase;
  UserCubit(
    this.signUpUseCase,
    this.signInUseCase,
    this.firebaseNotification,
    this.signOutUsceCase,
    this.notificationUseCase,
  ) : super(UserInitial());

  Future<void> SignUpUser(UserEntity userEntity, String password,File file) async {
    emit(UserLoading());
    try {
      await signUpUseCase.SignUp(userEntity, password,file);
      emit(UserLoaded());
    } catch (e) {
      emit(UserFailed());
    }
  }

  Future<void>Token()async{
    await firebaseNotification.call();
    await notificationUseCase.call();
  }



  Future<void> SignInuser(UserEntity user, String password) async {
    emit(UserLoading());
    try {
      await signInUseCase.Signin(user, password);
      emit(UserLoaded());
    } catch (e) {
      emit(UserFailed());
    }
  }

  Future<void> SignOutuser() async {
    emit(UserLoading());
    await signOutUsceCase.SignOutuser();
    emit(UserLoaded());
  }
}
