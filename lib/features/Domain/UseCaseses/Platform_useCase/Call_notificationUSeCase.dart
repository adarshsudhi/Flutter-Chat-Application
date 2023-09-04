
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class CallNotifcationUseCase {
  final FirebaseRepository repository;
  CallNotifcationUseCase({
    required this.repository,
  });
  Future<void>call(String content,String UserName,String FCM,String type)async{
    return repository.SendCallNofication(content, UserName, FCM,type);
  }
}
