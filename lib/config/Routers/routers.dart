import 'package:chat_application/features/presentation/pages/Editprofile/Editprofile.dart';
import 'package:chat_application/features/presentation/pages/Profile/Profile_Details.dart';
import 'package:chat_application/features/presentation/pages/Search/Search.dart';
import 'package:chat_application/features/presentation/pages/SingleChat/Chat.dart';
import 'package:chat_application/features/presentation/pages/VideoCall/VideoCall.dart';
import 'package:chat_application/features/presentation/widgets/DefaultPage.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/features/presentation/pages/AuthScreens/GetDetails.dart';
import 'package:chat_application/features/presentation/pages/Home/Homescreen.dart';
import 'package:chat_application/main.dart';
import '../../features/presentation/pages/AuthScreens/LoginPage.dart';
import '../../features/presentation/pages/AuthScreens/SignUppage.dart';

GenerateRoutes(RouteSettings routeSettings) {
  final args = routeSettings;
  switch (routeSettings.name) {
    case MainHomePage.Homescreen:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => MainHomePage());

    case MyApp.start:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => MyApp());

    case LoginPage.Login:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => LoginPage());

    case SignUpPage.SignUp:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => SignUpPage());

    case GetPic.FillDetails:
      if(args.name == GetPic.FillDetails){
        final parameters = args.arguments as GetPic; 
        return MaterialPageRoute(builder: (context)=>GetPic(name: parameters.name, Email: parameters.Email, password: parameters.password));
      }else{
         return MaterialPageRoute(builder: (_)=>DefaultErrorPage());
      }

    case ProFile.Profilescreen:
    return MaterialPageRoute(builder: (context)=>ProFile());

    case ProfileDetails.ProfileDetailsScreen:
    return MaterialPageRoute(builder: (context)=>ProfileDetails());

    case Searchuser.SearchScreen:
    return MaterialPageRoute(builder: (context)=>Searchuser());

    case MainChat.mainchat:
      if(args.name == MainChat.mainchat){
        final parameters = args.arguments as MainChat;
        return MaterialPageRoute(builder: (context)=>MainChat
        (name: parameters.name,
         uid: parameters.uid,
          photourl: parameters.photourl,
           Chatid: parameters.Chatid,
            currentuseruid: parameters.currentuseruid,
             Frienduid: parameters.Frienduid));
      }else{
        return MaterialPageRoute(builder: (_)=>DefaultErrorPage());
      }

      case VideoCallPage.VideoCallscreen:
      final parameter = args.arguments as VideoCallPage;
        return MaterialPageRoute(builder: (context)=>VideoCallPage(userName: parameter.userName,token: parameter.token,uid: parameter.uid,));

     default:
       return MaterialPageRoute(builder: (context)=>DefaultErrorPage());
  }
}

