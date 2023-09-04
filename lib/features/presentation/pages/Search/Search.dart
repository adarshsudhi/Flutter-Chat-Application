import 'package:chat_application/features/presentation/pages/SingleChat/Chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/constants.dart';
import '../../../Domain/Entity/User/user_entity.dart';
import '../../Cubit/search/search_cubit.dart';
import '../../widgets/Appbar.dart';

class Searchuser extends StatefulWidget {
  static const String SearchScreen = 'SearchScreen';
  const Searchuser({super.key});

  @override
  State<Searchuser> createState() => _SearchuserState();
}

class _SearchuserState extends State<Searchuser> {
   UserEntity? user;
  _search(String name) async {
    await BlocProvider.of<SearchCubit>(context).Getsearch(name);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  final _Searchcontroller = TextEditingController();

  _clear() {
    _Searchcontroller.clear();
  }

  Createid(String Currentuserid, String Friendid) {
    if (Currentuserid.toLowerCase().codeUnits[0] >
        Friendid.toLowerCase().codeUnits[0]) {
      return "${Currentuserid}${Friendid}";
    } else {
      return "${Friendid}${Currentuserid}";
    }
  }

  @override
  void dispose() {
    _Searchcontroller.dispose();
    user;
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomescreenColor,
      appBar: CustomAppbar("Search", Icons.arrow_back_ios_new, context, () {
        Navigator.of(context).pop();
      }),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                        
                          onFieldSubmitted: (value) {
                               if (value.isNotEmpty) {
                                  _search(value.trim());
                                  _clear();
                                } else {
                                  Showtoast("Enter Search User");
                                }
                          },
                          controller: _Searchcontroller,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: HomescreenColor, width: 3)),
                              hintText: "Search User",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      Kwidth1,
                      GestureDetector(
                        
                       onTap: () {
                           if (_Searchcontroller.text.isNotEmpty) {
                                  _search(_Searchcontroller.text.trim());
                                  _clear();
                                } else {
                                  Showtoast("Enter Search User");
                                }
                       },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 10, 19, 68)
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(Icons.search),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Kheight30,
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is Searchloading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: HomescreenColor,
                          ),
                        );
                      } else if (state is Searchloaded) {
                        return Expanded(
                            child: Container(
                          child: ListView.builder(
                            itemCount: state.entity.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                trailing: IconButton(
                                    onPressed: () async {
                                      final id = await Createid(
                                          auth.currentUser!.uid,
                                          state.entity[index].uid);
                                    /*  Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => MainChat(
                                                  name:
                                                      state.entity[index].name,
                                                  uid: state.entity[index].uid,
                                                  photourl: state
                                                      .entity[index].profileurl,
                                                  Chatid: id,
                                                  currentuseruid:
                                                      auth.currentUser!.uid,
                                                  Frienduid: state
                                                      .entity[index].uid)));*/
                                          Navigator.pushNamed(context, MainChat.
                                          mainchat,arguments: MainChat(name:
                                                      state.entity[index].name,
                                                  uid: state.entity[index].uid,
                                                  photourl: state
                                                      .entity[index].profileurl,
                                                  Chatid: id,
                                                  currentuseruid:
                                                      auth.currentUser!.uid,
                                                  Frienduid: state
                                                      .entity[index].uid));
                                    },
                                    icon: Icon(Icons.message)),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.entity[index].profileurl),
                                  radius: 30,
                                ),
                                title: Text(
                                  state.entity[index].name,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black, fontSize: 20),
                                ),
                                subtitle: Text(
                                  state.entity[index].about,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              );
                            },
                          ),
                        ));
                      } else {
                        return Flexible(
                          child: Container(
                            height: MediaQuery.of(context).size.height /1.7,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Center(
                                      child: Image.asset(
                                        "assets/searchuser.jpg",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class Showtiles extends StatelessWidget {
  const Showtiles({
    Key? key,
    required this.user,
    required this.url,
    required this.ontap,
    required this.subtitile,
  }) : super(key: key);

  final String user;
  final String url;
  final VoidCallback ontap;
  final String subtitile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: url.isNotEmpty
            ? NetworkImage(url)
            : AssetImage("assets/profile-pic.jpeg") as ImageProvider,
      ),
      title: Text(
        user,
        style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
      ),
      subtitle: Text(subtitile),
      trailing: IconButton(onPressed: ontap, icon: Icon(Icons.chat)),
    );
  }
}
