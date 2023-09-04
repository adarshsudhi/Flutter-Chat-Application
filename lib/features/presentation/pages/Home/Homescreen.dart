import 'package:chat_application/config/constants/constants.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/offline_user_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/onlin_user_UseCase.dart';
import 'package:chat_application/features/presentation/Cubit/RegisterUser/user_cubit.dart';
import 'package:chat_application/features/presentation/pages/Home/widgets/HomeUsers.dart';
import 'package:chat_application/features/presentation/pages/Setting/SettingDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../Cubit/Profile/profile_cubit.dart';
import '../Search/Search.dart';
import 'package:chat_application/Injecion_container.dart' as di;




class MainHomePage extends StatefulWidget {
  static const String Homescreen = 'Homescreen';
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> with WidgetsBindingObserver {
  SpeechToText _speechToText =SpeechToText();
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 FirebaseAuth _auth = di.Getit<FirebaseAuth>();

  DeviceToken()async{
   await BlocProvider.of<UserCubit>(context).Token();
  }
  void _GetProfile() async {
    await BlocProvider.of<ProfileCubit>(context).Get();
  }

  void OpenDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }
      
 
@override
  void initState() {
    super.initState();
    if (mounted) {
       WidgetsBinding.instance.addObserver(this);
    }
    DeviceToken();
   _GetProfile();
    di.Getit<onllineUserUsaeCase>().call(_auth.currentUser!.uid);
 //  _initSpeech();
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
       WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
     if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
       di.Getit<offineUserUsaeCase>().call(_auth.currentUser!.uid);
     }else if(state == AppLifecycleState.resumed){
       di.Getit<onllineUserUsaeCase>().call(_auth.currentUser!.uid);
     }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 2,
      animationDuration: Duration.zero,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: HomescreenColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: HomescreenColor,
            title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
       Container(
          decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)),
         child: IconButton(
             onPressed: () async{    
               OpenDrawer();
             },
             icon: Image.asset('assets/menu.png',fit: BoxFit.fitWidth,color: Colors.white,)),
       ),
              Text(
                  "Messages",
                style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 25),
              ),
              Container(
                width: 55,
                decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    onPressed: () {
                    
                    Navigator.pushNamed(context, Searchuser.SearchScreen);
                    },
                    icon: Image.asset('assets/transparency.png',fit: BoxFit.fitWidth,color: Colors.white,)),
              ),
            ],
          ) ,
            bottom: TabBar(
              isScrollable: false,
                labelStyle: TextStyle(fontSize: 13),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                tabs: [
                  SizedBox(
                      height: 40,
                      child: Center(
                          child: Text(
                        "Chats",
                        style: GoogleFonts.aBeeZee(),
                      ))),
                  SizedBox(
                      child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Groups',
                              style: GoogleFonts.aBeeZee(),
                            ),
                          )))
                ]),
          ),
        ),
        body: _TabBarWidget1(),
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        drawerEnableOpenDragGesture: true,
      ),
    );
  }
    void _initSpeech()async{
      await _speechToText.initialize();
   setState(() {
     
   });
  }
}

Widget _TabBarWidget1() {
  return HomeScreen();
}




