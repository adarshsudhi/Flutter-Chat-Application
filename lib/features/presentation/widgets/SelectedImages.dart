// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:chat_application/config/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SelectedImagesPage extends StatefulWidget {
  final List<XFile>? file;
  final String Chatid;
  final String Photourl;
  SelectedImagesPage({
    Key? key,
    required this.file,
    required this.Chatid,
    required this.Photourl,
  }) : super(key: key);

  @override
  State<SelectedImagesPage> createState() => _SelectedImagesPageState();
}

class _SelectedImagesPageState extends State<SelectedImagesPage> {
  bool _iscanceled = false;
  bool _isChecked = true;
  String Getday() {
    DateTime dateTime = DateTime.now();
    String chatday = DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
    return chatday;
  }

  _dispose() {
    widget.file!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.file!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(
                            File(widget.file![index].path),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        onPressed: () {
                          _dispose();

                          Navigator.pop(context, _iscanceled);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black,
                        )),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, _isChecked);
                        },
                        icon: Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              Kheight30,
            ],
          ),
        ),
      ),
    );
  }
}
