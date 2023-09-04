import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../Cubit/Chat/chat_cubit.dart';

class Externals {
  Future<XFile?> pickimagee(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    return file;
  }

  ViewImage(String URL, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
        ),
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  child: Image.network(
                    URL,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  read(String Chatid, String curretnuseruid, BuildContext context) {
    BlocProvider.of<ChatCubit>(context).readmessages(Chatid, curretnuseruid);
  }

  String Getday() {
    DateTime dateTime = DateTime.now();
    String chatday = DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
    return chatday;
  }

  GetCurrentime(String date) {
    DateTime dateTime = DateTime.now();
    String Curretntime = DateFormat('hh:mm a').format(dateTime);
    return Curretntime;
  }

  Future<List<XFile>> pickimage() async {
    ImagePicker picker = ImagePicker();
    List<XFile> file = await picker.pickMultiImage(
        requestFullMetadata: true, imageQuality: 100);

    return file;
  }

  movetobottom(ItemScrollController itemScrollController, int count) {
    itemScrollController.scrollTo(
        index: count + 1, duration: Duration(seconds: 1));
  }
}
