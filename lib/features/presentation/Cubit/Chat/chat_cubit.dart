import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_application/features/Domain/Entity/Chat/ChatEntity.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/GetHomeuser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/Getchats_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/ReadUnreadmessages_UseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/UseCaseses/Firebase_UseCase/Chat/SendMessage_UseCase.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendmessage;
  final GetchatsUseCase chatUsecase;
  final GetHomeUserUseCase useCase;
  final ReadUnreadMessagesUseCase readUnreadMessagesUseCase;
  ChatCubit(
    this.sendmessage,
    this.chatUsecase,
    this.useCase,
    this.readUnreadMessagesUseCase,
  ) : super(ChatInitial());

  Future<void> send(ChatEntity entity) async {
    emit(Chatloading());
    try {
      await sendmessage.send(entity);
      emit(chatloaded());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> Gethomeuser() {
    emit(Chatloading());
    emit(HomeUserloaded());
    final response = useCase.Gethomeuser();
    return response;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getchat(String Chatid) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> response =
        chatUsecase.call(Chatid);
    return response;
  }

  Future readmessages(String Chatid, String Currentuseruid) async {
    await readUnreadMessagesUseCase.call(Chatid, Currentuseruid);
  }
}
