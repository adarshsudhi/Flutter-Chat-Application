import 'package:chat_application/config/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final IconData icons;
  final bool obsecure;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.obsecure,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: (value) {
      if (value == null || value.isEmpty) {
            return "Enter $hinttext";
          }
          return null;
        },
        obscureText: obsecure,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icons,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HomescreenColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 4,
                  color: HomescreenColor,
                )),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: hinttext,
            hintStyle: GoogleFonts.actor(color: Colors.black)),
      ),
    );
  }
}
