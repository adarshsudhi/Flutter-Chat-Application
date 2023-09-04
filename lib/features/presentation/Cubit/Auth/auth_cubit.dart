import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/GetCurrentUseruid_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/IsSignedIn_UseCase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignedInUseCase _isSignedInUseCase;
  final GetCurrentUserUIDUseCase _getCurrentUserUIDUseCase;
  
  AuthCubit(
    this._isSignedInUseCase,
    this._getCurrentUserUIDUseCase,
  ) : super(AuthInitial());


  Future<String> getuid() async {
    final get = _getCurrentUserUIDUseCase.GetUID();
    return get;
  }

  Future<void> Ready(BuildContext context) async {
    try {
      
      emit(Authloading());
      bool issigned = await _isSignedInUseCase.IsSignedIn();

      if (issigned == true) {
        final Currentuser = await _getCurrentUserUIDUseCase.GetUID();

        emit(AccessGranted(Currentuser));
      } else {
        emit(AccessDenied());
      }
    } catch (e) {
      emit(AccessDenied());
    }
  }

  Future<bool> IsAuthentcated() async {
    bool signed = await _isSignedInUseCase.IsSignedIn();
    return signed;
  }
}
