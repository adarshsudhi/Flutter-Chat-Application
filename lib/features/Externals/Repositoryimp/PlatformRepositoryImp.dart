import 'package:chat_application/features/Domain/Repository/Platform_Repository/Platform_Repository.dart';
import 'package:chat_application/features/Externals/DataSource/Platform_repository_imp.dart/PlatformDataSource.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class PlatFormRepositoryimp implements PlatFormRepository {
  final PlatformDataSource source;
  PlatFormRepositoryimp({
    required this.source,
  });

  @override
  Future<void> NotificationMessages() async{
    source.NotificationMessages();
  }

  @override
  Future<void> ShowNotification(RemoteMessage message) async{
    source.ShowNotification(message);
  }

  @override
  Future<void> intialize() async{
    source.intialize();
  }
  
  @override
  Future<void> ShowCallNotification(RemoteMessage message,String type) async{
     source.ShowCallNotification(message,type);
  }
  
}
