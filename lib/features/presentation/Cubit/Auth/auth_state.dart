part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authloading extends AuthState {}

class AccessGranted extends AuthState {
  final String uid;

  AccessGranted(this.uid);
}

class AccessDenied extends AuthState {}

