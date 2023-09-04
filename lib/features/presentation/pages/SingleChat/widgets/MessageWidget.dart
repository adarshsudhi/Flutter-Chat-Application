import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Messagetextwidget extends StatelessWidget {
  const Messagetextwidget({
    Key? key,
    required TextEditingController messagecontroller,
  }) : _messagecontroller = messagecontroller;

  final TextEditingController _messagecontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        controller: _messagecontroller,
        style: GoogleFonts.actor(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Hey! there send something",
            hintStyle: GoogleFonts.actor(color: Colors.white.withOpacity(0.3)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
