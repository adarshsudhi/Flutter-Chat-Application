import 'package:firebase_messaging/firebase_messaging.dart';

abstract class PlatformDataSource {
  Future<void>intialize();
  Future<void>ShowNotification(RemoteMessage message);
  Future<void>ShowCallNotification(RemoteMessage message,String type);
  Future<void>NotificationMessages();
}