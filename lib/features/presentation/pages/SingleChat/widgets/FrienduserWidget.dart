import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/constants/constants.dart';
import '../../../widgets/Externals.dart';
import '../Chat.dart';

class Frienduserwidget extends StatefulWidget {
  const Frienduserwidget({
    super.key,
    required this.widget,
    required this.data,
    required this.ChatTime,
  });

  final MainChat widget;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String ChatTime;

  @override
  State<Frienduserwidget> createState() => _FrienduserwidgetState();
}

class _FrienduserwidgetState extends State<Frienduserwidget> {
  List<dynamic>? URLS = [];

  _Get() {
    setState(() {
      URLS = widget.data['fileurl'];
    });
  }

  @override
  void initState() {
    super.initState();
    _Get();
  }

  Externals externals = Externals();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: widget.widget.photourl.isNotEmpty
                ? CachedNetworkImageProvider(widget.widget.photourl)
                : const AssetImage("assets/profile-pic.jpeg")
                    as ImageProvider,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    URLS!.length == 0
                        ? Container()
                        : Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 158, 211, 255)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GridView.builder(
                              physics: URLS!.length <= 1
                                  ? NeverScrollableScrollPhysics()
                                  : ScrollPhysics(),
                              itemCount: URLS!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: URLS!.length > 1 ? 2 : 1),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return externals.ViewImage(
                                            URLS![index],
                                            context,
                                          );
                                        },
                                      );
                                    },
                                    child: Image.network(
                                      URLS![index],
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    Kheigth10,
                  widget.data['message'] == ''?Container():  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 25, top: 10, bottom: 10),
                        child: Text(
                          widget.data['message'],
                          style: GoogleFonts.aBeeZee(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Text(
                            widget.ChatTime,
                            style: GoogleFonts.aBeeZee(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          
                        ),
                        Kwidth1,
                        Text(widget.data['day'],style: GoogleFonts.aBeeZee(fontSize: 11),)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
