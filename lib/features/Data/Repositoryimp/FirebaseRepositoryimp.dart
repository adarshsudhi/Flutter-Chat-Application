import 'dart:async';
import 'dart:io';
import 'package:chat_application/features/Domain/Entity/Chat/ChatEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_application/features/Data/DataSource/RemoteDataSource/RemoteDataSource.dart';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../../Domain/Entity/Chat/LastMessageEntity.dart';

class FirebaseRepositoryimpl implements FirebaseRepository {
  final RemoteDataSource source;

  FirebaseRepositoryimpl({required this.source});

  @override
  Future<String> GetCurrentUserUid() async => source.GetCurrentUserUid();

  @override
  Future<bool> IsSignedIn() async => source.IsSignedIn();


  @override
  Stream<List<UserEntity>> SearchUser(String name) => source.SearchUser(name);

  @override
  Future<void> SignInuser(UserEntity user, String password) async =>
      source.SignInuser(user, password);

  @override
  Future<void> SignUpuser(UserEntity user, String password, File file) async =>
      source.SignUpuser(user, password, file);

  @override
  Future<void> SignOutuser() {
    return source.SignOutuser();
  }

  @override
  Future<String> UploadImagetostroage(File file) async =>
      source.UploadImagetostroage(file);

  @override
  Future<void> UploadUserdetails(UserEntity enitity, File filee) async {
    return source.UploadUserdetails(enitity, filee);
  }

  @override
  Future<List<UserEntity>> GetProfile() async => source.GetProfile();

  @override
  Future<void> SendMessage(ChatEntity chatEntity) async =>
      source.SendMessage(chatEntity);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> Getchats(entity) =>
      source.Getchats(entity);

  @override
  Future<List<UserEntity>> GetaSingleUser(String UID) async =>
      source.GetaSingleUser(UID);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> GetHomeuser() =>
      source.GetHomeuser();

  @override
  Future<int> Getunreadmessages(String Chatid, String friendid) async =>
      source.Getunreadmessages(Chatid, friendid);

  @override
  Future<LastMessageEntity> GetlastRecievedMEssage(String uid) async =>
      source.GetlastRecievedMEssage(uid);

  @override
  Future<void> UpdateHomeuser(List<UserEntity> currentuser,
          List<UserEntity> Frienduser, ChatEntity chatEntity) async =>
      source.UpdateHomeuser(currentuser, Frienduser, chatEntity);

  @override
  Future<List<String>> Uploadattachedfile(
          List<XFile> file, String Chatid) async =>
      source.Uploadattachedfile(file, Chatid);

  @override
  Future<void> UpdatelastRecieved(ChatEntity chatEntity,
          String Currentuserdocid, String Frienduserdocid) async =>
      source.UpdatelastRecieved(chatEntity, Currentuserdocid, Frienduserdocid);

  @override
  Future<void> readUnreadmessages(String Chatid, String Currentuseruid) async =>
      source.readUnreadmessages(Chatid, Currentuseruid);


      
  @override
  Future<void> InitializeNotification() async{
           source.InitializeNotification();
        }
        
       
  @override
  Future<void> SendNotification(String content, String UserName,String FCM) async{
       source.SendNotification(content, UserName,FCM);
   }
          
  @override
  Future<void> SendCallNofication(String content,String UserName,String FCM,String type) async{
    source.SendCallNofication(content, UserName, FCM,type);
  }
  
  @override
  Future<String> GenerateTempToken(String channelname,String uid) async{
   return source.GenerateTempToken(channelname,uid);
  }
  
  @override
  Future<void> SetOnline(String uid) async{
    return source.SetOnline(uid);
  }
  
  @override
  Future<void> setoffline(String uid) async{
  return source.setoffline(uid);
  }
}