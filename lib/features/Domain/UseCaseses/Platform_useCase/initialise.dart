import 'package:chat_application/features/Domain/Repository/Platform_Repository/Platform_Repository.dart';

class IntialiseUseCase {
  final PlatFormRepository repository;
  IntialiseUseCase({
    required this.repository,
  });
  Future<void>call()async{
    return repository.intialize();
  }
}
