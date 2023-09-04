// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/features/Domain/Repository/Platform_Repository/Platform_Repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CallRecievedUSeCase {
  final PlatFormRepository repository;
  CallRecievedUSeCase({
    required this.repository,
  });
 Future<void>call(RemoteMessage message,String type)async{
  return repository.ShowCallNotification(message,type);
 } 
}
