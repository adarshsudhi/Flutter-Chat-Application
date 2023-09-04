// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class Chatloading extends ChatState {}

class chatloaded extends ChatState {}

class Getloadedchat extends ChatState {
  final List<ChatEntity> entity;
  Getloadedchat({
    required this.entity,
  });
  @override
  List<Object> get props => [entity];
}

class HomeUserloaded extends ChatState {}
