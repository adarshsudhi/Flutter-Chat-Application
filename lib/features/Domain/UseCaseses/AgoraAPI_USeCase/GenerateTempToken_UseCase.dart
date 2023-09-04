// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';

class GenerateTempTokenUseCase {
  final FirebaseRepository repository;
  GenerateTempTokenUseCase({
    required this.repository,
  });
  
Future<String>call(String channelname,String uid)async{
  return repository.GenerateTempToken(channelname,uid);
}
}
