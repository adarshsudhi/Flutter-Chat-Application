import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/features/Externals/DataSource/Platform_repository_imp.dart/PlatformDataSource.dart';
import '../../../presentation/pages/VideoCall/VideoCall.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    @pragma("vm:entry-point")
    Future<void> handleAcceptAction(ReceivedAction action,RemoteMessage message) async {
     if (message.data['call_type'] == 'video') {
       navigatorKey.currentState!.pushNamed(VideoCallPage.VideoCallscreen,arguments:    
       VideoCallPage(userName: message.data['channelname'],uid: 2,token: message.data['token']));
     }
}

@pragma("vm:entry-point")
Future<void> handleRejectAction(ReceivedAction action) async {
  if (action.buttonKeyPressed == 'REJECT') {
      print("call Rejected"); //for reject handling
  }
}

class PlatoformDataSourceImp implements PlatformDataSource {

  @override
  Future<void> NotificationMessages() async{  
        FirebaseMessaging.onMessage.listen((event) {
         if (event.data['call_type'] == 'video') {
         ShowCallNotification(event,'Incoming Video');
         AwesomeNotifications().setListeners(onActionReceivedMethod:(receivedAction) async{
         if (receivedAction.buttonKeyPressed == 'ACCEPT') {
         handleAcceptAction(receivedAction,event);
         } else if (receivedAction.buttonKeyPressed == 'REJECT') {
         handleRejectAction(receivedAction);
         }
         });
        }else{
          ShowNotification(event);
        }
       });
  }

  @override
  Future<void> ShowNotification(RemoteMessage message)async {
    await AwesomeNotifications().createNotification(content: 
     NotificationContent(
         id: 456,
         channelKey: 'message_channel',
         color: Colors.white,
         title: "Message From ${message.data['title']}",
         body: '${message.data['body']}',
         category: NotificationCategory.Message,
         wakeUpScreen: true,
         fullScreenIntent: true,
         autoDismissible: false,
         backgroundColor: Color.fromARGB(255, 236, 172, 75),   
         displayOnBackground: true,
         displayOnForeground: true,
         ticker: 'ticker'
         ),);
  }

  @override
  Future<void> intialize() async{
   AwesomeNotifications().initialize(null,[
    NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'call_channel',
        channelDescription: 'channel_for_calling',
        importance: NotificationImportance.Max,
        locked: true,
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
        defaultColor: Color.fromARGB(255, 233, 182, 99),
        playSound: true,
        enableVibration: true,
        onlyAlertOnce: false,
        criticalAlerts: true
        ),
        NotificationChannel(
        channelKey: 'message_channel',
        channelName: 'message_channel',
        channelDescription: 'channel_for_messaging',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        defaultColor: Color.fromARGB(255, 233, 182, 99),
        playSound: true,
        enableVibration: true,
        criticalAlerts: true,
        onlyAlertOnce: true
        ),
   ],
   );
  }
  
  @override
  Future<void> ShowCallNotification(RemoteMessage message,String type) async {
    await  AwesomeNotifications().createNotification(content: NotificationContent(
         id: 123,
         channelKey: 'call_channel',
         color: Colors.white,
         title: message.data['channelname'],
         body: '$type From ${message.data['channelname']}',
         category: NotificationCategory.Call,
         wakeUpScreen: true,
         locked: true,
         displayOnBackground: true,
         fullScreenIntent: true,
         autoDismissible: false,
         backgroundColor: Colors.orange,   
         ),
        actionButtons: [
         NotificationActionButton(key: 'ACCEPT', label: 'accept',autoDismissible: true,color: Colors.green),
         NotificationActionButton(key: "REJECT", label: 'reject',autoDismissible: true,color: Colors.red)
        ],
       );
  } 
}
