import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Domain/Entity/Chat/ChatEntity.dart';
import '../../../Domain/Entity/Chat/LastMessageEntity.dart';
import '../../../Domain/Entity/User/user_entity.dart';

abstract class RemoteDataSource {
  Future<void> SignUpuser(UserEntity user, String password, File file);
  Future<void> SignInuser(UserEntity user, String password);
  Future<bool> IsSignedIn();
  Future<void> SignOutuser();
  Future<void>InitializeNotification();
  Future<void>SendNotification(String content,String UserName,String FCM);
  Future<void>SendCallNofication(String content,String UserName,String FCM,String type);

  Stream<List<UserEntity>> SearchUser(String name);
  Future<String> GetCurrentUserUid();
  Future<void>setoffline(String uid);
  Future<void>SetOnline(String uid);

  Future<void> UploadUserdetails(UserEntity enitity, File filee);
  Future<String> UploadImagetostroage(File file);
  Future<List<UserEntity>> GetProfile();
  Future<void> SendMessage(ChatEntity chatEntity);
  Stream<QuerySnapshot<Map<String, dynamic>>> Getchats(String Chatid);
  Future<List<UserEntity>> GetaSingleUser(String UID);
  Stream<QuerySnapshot<Map<String, dynamic>>> GetHomeuser();
  Future<int> Getunreadmessages(String Chatid, String friendid);
  Future<LastMessageEntity> GetlastRecievedMEssage(String uid);
  Future<void> UpdateHomeuser(List<UserEntity> currentuser,
      List<UserEntity> Frienduser, ChatEntity chatEntity);
  Future<void> UpdatelastRecieved(
      ChatEntity chatEntity, String Currentuserdocid, String Frienduserdocid);
  Future<List<String>> Uploadattachedfile(List<XFile> file, String Chatid);
  Future<void> readUnreadmessages(String Chatid, String Currentuseruid);
//  Future<void> CreateGroup(
 //     GroupEntity groupEntity, XFile file, List<UserEntity> users);
 // Future<void> AddGroupsToMembers(
 //     List<UserEntity> user, GroupEntity groupEntity, String Url);
 // Future<void> SendGroupsMessage(ChatEntity chatEntity);
 // Stream<QuerySnapshot<Map<String, dynamic>>> ReadGroups(String CurretnUserUid);
//  Stream<QuerySnapshot<Map<String, dynamic>>> GetGroupChats(String Chatid);
 // Future<void> ReadUnreadGroupMessages(String Chatid, String CurrentuserUid);
 // Future<void> GetUnreadGroupMessages(String Chatid, String currentuser);
 // Future<void> ReadGroupmessages(String Chatid, String Currentuser);
 // Future<void>ClearAllChats(String Chatid);
  Future<String>GenerateTempToken(String channelname,String uid);
 // Stream<QuerySnapshot<Map<String, dynamic>>>getOnlineUsers(String Currentuseruid);
}
