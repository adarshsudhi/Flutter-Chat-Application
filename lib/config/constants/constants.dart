import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String ServerKey = 'AAAAy3rSMgA:APA91bEbq96coCF5gTiasszFZAzBrnfGI1biaOwbeIKiNqFLTLBAvHM_8WWkm7NhgH0e1-EWn1G_wa4djfTBYjMPqioZFpN6flP1TKfrICCoz3XFWweH7d53CDetyhZ5bQ08XNxYI2Dg';
String AppCertificate = '862e6112230640808517e94ea45a9406';
String AppId = 'd6e2285f6e0340839e18c4fecf3ddc46';
String Baseurl = 'http://192.168.18.49:3000/generate/rtc';

String Endpoint(String channelname,String uid){
   return '${Baseurl}/$channelname/publisher/uid/$uid';
}

Color backgroundColor = Color.fromARGB(255, 3, 9, 43);
Color HomescreenColor = Color.fromARGB(255, 1, 7, 41);
SizedBox Kheigth10 = const SizedBox(
  height: 10,
);
SizedBox Kheight20 = const SizedBox(
  height: 20,
);

SizedBox Kheight30 = const SizedBox(
  height: 30,
);

void Showtoast(String content) {
  Fluttertoast.showToast(
      msg: content, textColor: Colors.white, backgroundColor: Colors.black);
}

SizedBox Kwidth1 = const SizedBox(
  width: 10,
);
SizedBox Kwidth0 = const SizedBox(
  width: 30,
);

BorderRadiusGeometry radiuss() {
  return const BorderRadius.only(
      topLeft: Radius.circular(60), topRight: Radius.circular(60));
}

Divideer() {
  return Divider(
    thickness: 2,
    color: Colors.grey.withOpacity(0.5),
  );
}


