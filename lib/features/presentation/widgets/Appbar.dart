import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants/constants.dart';

PreferredSizeWidget CustomAppbar(final String text, final IconData icons,
    BuildContext context, VoidCallback ontap) {
  return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: HomescreenColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
                onPressed: ontap,
                icon: Icon(
                  icons,
                  size: 20,
                  color: Colors.white,
                )),
          ),
        ),
        title: Text(
          text,
          style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
        ),
      ));
}
