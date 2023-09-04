import 'dart:async';
import 'dart:io';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/Domain/UseCaseses/AgoraAPI_USeCase/GenerateTempToken_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/GetSingleUser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/Call_notificationUSeCase.dart';
import 'package:chat_application/features/presentation/Cubit/UploadFiles/upload_files_cubit.dart';
import 'package:chat_application/features/presentation/pages/SingleChat/widgets/CurrenuserWidget.dart';
import 'package:chat_application/features/presentation/pages/SingleChat/widgets/FrienduserWidget.dart';
import 'package:chat_application/features/presentation/pages/SingleChat/widgets/MessageWidget.dart';
import 'package:chat_application/features/presentation/pages/VideoCall/VideoCall.dart';
import 'package:chat_application/features/presentation/widgets/SelectedImages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:chat_application/config/constants/constants.dart';
import 'package:chat_application/features/Domain/Entity/Chat/ChatEntity.dart';
import 'package:chat_application/features/presentation/Cubit/Chat/chat_cubit.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../widgets/Externals.dart';
import 'package:chat_application/Injecion_container.dart' as di;

class MainChat extends StatefulWidget {
  static const String mainchat = '/Chatscreen';
  final String name;
  final String uid;
  final String photourl;
  final String Chatid;
  final String currentuseruid;
  final String Frienduid;
  MainChat({
    Key? key,
    required this.name,
    required this.uid,
    required this.photourl,
    required this.Chatid,
    required this.currentuseruid,
    required this.Frienduid,
  }) : super(key: key);

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> with SingleTickerProviderStateMixin{
  double? _scale; 
  String TOKEN1 = '';
  String TOKEN2 = '';
  SpeechToText _speechToText =SpeechToText();
  late AnimationController _controller;
  final Externals externals = Externals();
  List<UserEntity>? CurrentuserDetials;
  List<UserEntity>? FriendUserDetials;
  final GenerateToken = di.Getit<GenerateTempTokenUseCase>();
  final Sendnotification = di.Getit<CallNotifcationUseCase>();
  final Temptoken = di.Getit<GenerateTempTokenUseCase>();
  final messagecontroller = TextEditingController();
  final GetFrienduser = di.Getit<GetSingleUserUseCase>();
  Stream<QuerySnapshot<Map<String, dynamic>>>? response;
  ItemScrollController _itemScrollController = ItemScrollController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  int count = 0;
  List<String> FileURL = [];
  List<XFile> file = [];
  _clear() {
    messagecontroller.clear();
  }

  _getCurrentuserDetials(String uid)async{
    CurrentuserDetials = await GetFrienduser.GetsingleUser(uid);
     TOKEN1 = await Temptoken.call(CurrentuserDetials![0].name,'1');
     TOKEN2 = await Temptoken.call(CurrentuserDetials![0].name,'2');
     print(CurrentuserDetials![0].name);
  }
    _getFrienduserDetials(String uid)async{
   FriendUserDetials = await GetFrienduser.GetsingleUser(uid);
     print(FriendUserDetials![0].name);
  }

  _get() async {
    response = await BlocProvider.of<ChatCubit>(context).getchat(widget.Chatid);
    setState(() {});
  }

  updateValue(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        count = snapshot.data!.size;
      });
    });
  }
  _sendnotification(String type)async{
    await Sendnotification.call(TOKEN2,CurrentuserDetials![0].name.trim(),FriendUserDetials![0].DeviceToken,type);
  }

  _dispose() {
    if (file.isNotEmpty) {
      file = [];
    }
  }

  @override
  void initState() {
    super.initState();
    _get();
    _getFrienduserDetials(widget.Frienduid);
    _getCurrentuserDetials(widget.currentuseruid);
    externals.read(widget.Chatid, widget.currentuseruid, context);
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 500),
    lowerBound: 0.0,
    upperBound: 0.1)..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    file = [];
    messagecontroller.dispose();
    response = null;
  }


  @override
  Widget build(BuildContext context) {
    double sizew = MediaQuery.sizeOf(context).width;
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: HomescreenColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
                  IconButton(onPressed: ()async{
                   if (FriendUserDetials![0].online == false) {
                       Showtoast('The user is not online');
                   }else{
                        _sendnotification('video');
                        Navigator.pushNamed(context,VideoCallPage.VideoCallscreen,arguments: VideoCallPage(userName: CurrentuserDetials![0].name,token: TOKEN1,uid: 1,));
                    }
                      
                  }, icon: Icon(Icons.videocam,color: Colors.black,)),
              
             
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
                  SizedBox(),
              Text(
                widget.name,
                style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 25),
              ),
              SizedBox(),
              Kwidth1,
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: StreamBuilder(
              stream: response,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  return SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              child: ScrollablePositionedList.builder(
                            itemScrollController: _itemScrollController,
                            itemCount: snapshot.data!.size,
                            initialScrollIndex: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.docs[index];
                              if (snapshot.data!.docs.length > count) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  externals.movetobottom(
                                      _itemScrollController, count);
                                  externals.read(widget.Chatid,
                                      widget.currentuseruid, context);
                                });
                              }
                              String ChatTime =
                                  externals.GetCurrentime(data['date']);

                              updateValue(snapshot);
                              count = snapshot.data!.size;
                              if (!data.exists) {
                                return Container();
                              }

                              return widget.currentuseruid == widget.Frienduid
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Center(
                                        child: Text(
                                          "This Feature is not available yet",
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : Align(
                                      alignment: data['currentuser'] ==
                                              widget.currentuseruid
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: data['currentuser'] ==
                                                widget.currentuseruid
                                            ? Padding(
                                              padding:  EdgeInsets.only(left: sizew/10),
                                              child: CurrentuserWidget(
                                                  data: data, ChatTime: ChatTime),
                                            )
                                            : Padding(
                                              padding: EdgeInsets.only(right: sizew/10),
                                              child: Frienduserwidget(
                                                  widget: widget,
                                                  data: data,
                                                  ChatTime: ChatTime),
                                            ),
                                      ),
                                    );
                            },
                          )),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          )),
          file.length == 0?SizedBox():Container(
                      height: 250,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: file.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(top: 20,bottom: 10,left: 20),
                                  child: Stack(
                                     children: [
                                      Image.file(File(file[index].path),fit: BoxFit.fitWidth,),
                                      IconButton(onPressed: (){
                                        file.removeAt(index);
                                      }, icon: Icon(Icons.cancel ,color: Colors.white,))
                                     ],));
                        }),
                 ),
          widget.currentuseruid == widget.Frienduid
              ? Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Sorry This Feature is not available yet!!",
                      style: GoogleFonts.aBeeZee(color: Colors.white),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(color: HomescreenColor),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                await externals.pickimage().then((value) async {
                                  if (value.isNotEmpty) {
                                    var returnvalue =
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectedImagesPage(
                                                      file: value,
                                                      Chatid: widget.Chatid,
                                                      Photourl: widget.photourl,
                                                    )));                                    
                                    if (returnvalue == true) {
                                      setState(() {
                                        file = value;
                                      });
                                    } else {
                                      setState(() {
                                        file = [];
                                      });
                                    }
                                  }
                                });
                              },
                              child: Icon(
                                Icons.attach_file_outlined,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                            Kwidth1,
                            Expanded(
                                child: Messagetextwidget(
                                    messagecontroller: messagecontroller)),
                            Row(children: [
                              Kwidth1,
                              InkWell(onTap: () async {
                                if (messagecontroller.text.isNotEmpty) {
                                  await _sendMessage(
                                    messagecontroller.text.trim(),
                                    context,
                                    FileURL.isEmpty ? [] : FileURL,
                                  ).then((value) {
                                    setState(() {
                                      file.clear();
                                      _get();
                                    });
                                  });
                                }else{
                                  if (file.isNotEmpty) {
                                    await _sendMessage('', context, FileURL);
                                  }
                                }
                              }, child: BlocBuilder<UploadFilesCubit,
                                  UploadFilesState>(
                                builder: (context, state) {
                                  if (state is UploadFilesloading) {
                                    return Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(82, 127, 89, 189),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                          child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )),
                                    );
                                  }
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTapUp: _tapUp,
                                        onTapDown: _tapDown,
                                        child: Transform.scale(
                                          scale: _scale,
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(82, 127, 89, 189),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Center(
                                                child: const Icon(
                                                  Icons.mic,
                                                  color: Colors.white,
                                                  size: 30,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Kwidth1,
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(82, 127, 89, 189),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                            child: Transform.rotate(
                                          angle: -140 / 180,
                                          child: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        )),
                                      ),
                                    ],
                                  );
                                },
                              ))
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(
      String content, BuildContext context, List<String> fileurl) async {
    if (file.isNotEmpty) {
      final response = await BlocProvider.of<UploadFilesCubit>(context)
          .Uploadattachedfile(file, widget.Chatid);
      setState(() {
        FileURL = response;
      });
    }
    String Chatdate = externals.Getday();
    ChatEntity entity = ChatEntity(
      SenderName: CurrentuserDetials![0].name,
      fileurl: FileURL.isEmpty ? [] : FileURL,
      day: Chatdate,
      read: false,
      frienduid: widget.Frienduid,
      url: widget.photourl,
      date: DateTime.now().toString(),
      chatid: widget.Chatid,
      message: content,
      currentuser: widget.currentuseruid,
    );
    _clear();
    await BlocProvider.of<ChatCubit>(context).send(entity).then((value) {
      setState(() {
        file.clear();
      fileurl.clear();
      });
    });
  }
  void _tapDown(TapDownDetails details)async{
    _controller.forward();
    await _speechToText.listen(onResult: _onspeechresult);
  }
  void _tapUp(TapUpDetails details) async{
    _controller.reverse();
    await _speechToText.stop();
  }

  void _onspeechresult(SpeechRecognitionResult recognitionResult)async{
    setState(() {
     messagecontroller.text = recognitionResult.recognizedWords;
    });
  }



}
