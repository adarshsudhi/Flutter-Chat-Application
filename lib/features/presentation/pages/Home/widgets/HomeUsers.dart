import 'package:chat_application/features/presentation/pages/Search/Search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../config/constants/constants.dart';
import '../../../Cubit/Chat/chat_cubit.dart';
import '../../SingleChat/Chat.dart';

class HomeScreen extends StatefulWidget {
  static const String Homescreen = "/Homescreen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? response;
  Stream<QuerySnapshot<Map<String, dynamic>>>? GetOnline;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;



  _get() async {
    if (mounted) {
      var pass = await BlocProvider.of<ChatCubit>(context).Gethomeuser();
      setState(() {
        response = pass;
      });
    }
  }

  GetCurrentime(String Date) {
    DateTime newData = DateTime.parse(Date);
    String Currentime = DateFormat('h:mm a').format(newData);
    return Currentime;
  }

  @override
  void initState() {
    super.initState();
    _get();
   
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return _get();
    });
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Kheigth10,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(80),topRight: Radius.circular(80))),
              child: Column(
                children: [
                  Kheight20,
                  Expanded(
                    child: Container(
                      child: BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          if (state is Chatloading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          } else if (state is HomeUserloaded) {
                            return Container(
                                child: StreamBuilder(
                              stream: response,
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                  
                                        final data = snapshot.data!.docs[index];
                                        String LastTime =
                                            GetCurrentime(data['Date']);
                                        String lasttextlength =
                                            data['lastmessage'];
                                        int textlenght = lasttextlength.length;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 10, bottom: 20),
                                          child: InkWell(
                                            onTap: () {
                                             /* Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) => MainChat(
                                                          name: data['name'],
                                                          uid: data[
                                                              'currentuseruid'],
                                                          photourl: data[
                                                              'profileurl'],
                                                          Chatid:
                                                              data['chatid'],
                                                          currentuseruid:
                                                              firebaseAuth
                                                                  .currentUser!
                                                                  .uid,
                                                          Frienduid: data[
                                                              'frienduid']))); */

                                                    Navigator.pushNamed(context,MainChat.mainchat,arguments: MainChat(
                                                     name: data['name'],
                                                          uid: data[
                                                              'currentuseruid'],
                                                          photourl: data[
                                                              'profileurl'],
                                                          Chatid:
                                                              data['chatid'],
                                                          currentuseruid:
                                                              firebaseAuth
                                                                  .currentUser!
                                                                  .uid, Frienduid: data[
                                                              'frienduid']));

                                                
                                            },
                                            child: ListTile(
                                              leading: Stack(
                                                  children: [
                                               CircleAvatar(
                                                radius: 30,
                                                backgroundImage: CachedNetworkImageProvider(data['profileurl']),
                                               ),                       
                                                   data['online']==true? Positioned(
                                                    top: 40,child: Container(height: 15,width: 15,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color.fromARGB(131, 0, 255, 13)))):SizedBox()
                                                  ],
                                                
                                              ),
                                              title: Text(
                                                data['name'],
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              subtitle: firebaseAuth
                                                          .currentUser!.uid !=
                                                      data['senderid']
                                                  ? Text(
                                                      data['lastmessage']
                                                                  .toString()
                                                                  .length >=
                                                              30
                                                          ? data['lastmessage']
                                                              .toString()
                                                              .replaceRange(
                                                                  30, null, '')
                                                          : data['lastmessage'],
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    )
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          'You :',
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        Text(
                                                          textlenght <= 25
                                                              ? data[
                                                                  'lastmessage']
                                                              : data['lastmessage']
                                                                  .toString()
                                                                  .replaceRange(
                                                                      25,
                                                                      textlenght,
                                                                      '....'),
                                                        )
                                                      ],
                                                    ),
                                              trailing:
                                                  data['unreadmessages'] != ''
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              LastTime,
                                                              style: GoogleFonts.aBeeZee(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5)),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  color:
                                                                      HomescreenColor),
                                                              height: 20,
                                                              width: 20,
                                                              child: Center(
                                                                child: Text(
                                                                  data[
                                                                      'unreadmessages'],
                                                                  style: GoogleFonts
                                                                      .aBeeZee(
                                                                          color:
                                                                              Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(),
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: HomescreenColor,
                                    ),
                                  );
                                }
                              },
                            ));
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Searchuser.SearchScreen);
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(color: HomescreenColor,borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
