// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

import 'package:chat_application/Injecion_container.dart' as di;
import 'package:chat_application/config/constants/constants.dart';

import '../../../Domain/Entity/User/user_entity.dart';
import '../../../Domain/UseCaseses/Firebase_UseCase/Chat/GetSingleUser_UseCase.dart';

class VideoCallPage extends StatefulWidget {
  static const String VideoCallscreen = './videocallpage';
  final String userName;
  final String token;
  final int uid;
  VideoCallPage({
    Key? key,
    required this.userName,
    required this.token,
    required this.uid,
  }) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  
    final GetFrienduser = di.Getit<GetSingleUserUseCase>();
   AgoraClient? _client;
   List<UserEntity> usernotifcationdetials = [];


   getAgoraClient()async{
    AgoraClient client = AgoraClient
    (agoraConnectionData: AgoraConnectionData(
      appId: AppId,
       channelName: widget.userName,
       tempToken: widget.token,
       uid:widget.uid));
    setState(() {
      _client = client;
    });
   }

   Initial()async{
    if (_client!=null) {
      await _client!.initialize();
    }
   }
  @override
  void initState() {

    super.initState();
    getAgoraClient();
    Initial();
  }

  @override
  void dispose() {
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         _client==null? Container():AgoraVideoViewer(client: _client!,layoutType: Layout.floating,),
         _client==null? Container():AgoraVideoButtons(client: _client!,)
        ],
      ),
    );
  }
}