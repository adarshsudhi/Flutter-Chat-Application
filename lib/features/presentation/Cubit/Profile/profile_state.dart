part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileFailed extends ProfileState {}

// ignore: must_be_immutable
class Getprofile extends ProfileState {
  List<UserEntity> enitity = [];
  Getprofile({required this.enitity});

  @override
  List<Object> get props => [enitity];
}
