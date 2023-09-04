
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';


class GetSingleUserUseCase {
  final FirebaseRepository repository;
  GetSingleUserUseCase({
    required this.repository,
  });
  Future<List<UserEntity>> GetsingleUser(String UID) async {
    return repository.GetaSingleUser(UID);
  }
}
