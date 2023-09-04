import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import '../../../Repository/Firebase_repository/Firebase_repository.dart';

class SearchUserUseCase {
  final FirebaseRepository repository;

  SearchUserUseCase(this.repository);
  Stream<List<UserEntity>> SearchUser(String name) {
    return repository.SearchUser(name);
  }
}
