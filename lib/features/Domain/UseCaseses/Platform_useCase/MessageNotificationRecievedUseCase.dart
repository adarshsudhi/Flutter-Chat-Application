import 'package:chat_application/features/Domain/Repository/Platform_Repository/Platform_Repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageNotificationUseCase {
   final PlatFormRepository repository;
  MessageNotificationUseCase({
    required this.repository,
  });
   Future<void>call(RemoteMessage message) async{
    return repository.ShowNotification(message);
   }
}
