import 'package:chat_application/features/Domain/Repository/Platform_Repository/Platform_Repository.dart';
class NotificationUseCase {
  final PlatFormRepository repository;
  NotificationUseCase({
    required this.repository,
  });
  Future<void>call()async{
    return repository.NotificationMessages();
  }
}
