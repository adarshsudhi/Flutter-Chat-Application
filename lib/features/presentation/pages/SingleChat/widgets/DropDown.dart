// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
class DropDownWidget extends StatefulWidget {
  final String Chatid;
  const DropDownWidget({
    Key? key,
    required this.Chatid,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {


   
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{

      },
      child: Container(
        height: 20,
        child: Center(child: Text("Clear chats")),
      ),
    );
  }
}