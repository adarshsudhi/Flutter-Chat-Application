part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class Searchloading extends SearchState {}

class Searchloaded extends SearchState {
  List<UserEntity> entity = [];
  Searchloaded({required this.entity});
  @override
  List<Object> get props => [entity];
}

class SearchEmpty extends SearchState {
  List<UserEntity> users = [];
  SearchEmpty({required this.users});
  @override
  List<Object> get props => [users];
}

class Searchfailed extends SearchState {}
