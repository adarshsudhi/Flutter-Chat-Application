import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/constants/constants.dart';
import '../../../widgets/Externals.dart';

class CurrentuserWidget extends StatefulWidget {
  CurrentuserWidget({
    Key? key,
    required this.data,
    required this.ChatTime,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final String ChatTime;

  @override
  State<CurrentuserWidget> createState() => _CurrentuserWidgetState();
}

class _CurrentuserWidgetState extends State<CurrentuserWidget> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        URLS!.length == 0
            ? Container()
            : Card(
                elevation: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: HomescreenColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: GridView.builder(
                    physics: URLS!.length <= 1
                        ? NeverScrollableScrollPhysics()
                        : ScrollPhysics(),
                    itemCount: URLS!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: URLS!.length > 1 ? 2 : 1),
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return externals.ViewImage(
                                    URLS![index], context);
                              },
                            );
                          },
                          child: CachedNetworkImage(imageUrl:URLS![index],fit: BoxFit.fitWidth,
                            ),
                        ),
                      );
                    },
                  ),
                ),
              ),
        Kheigth10,
       widget.data['message'] == ''?Container(): Container(
          decoration: BoxDecoration(
              color: HomescreenColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 15, bottom: 15),
            child: Center(
              widthFactor: 1.1,
              child: Text(
                widget.data['message'],
                style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(widget.data['day'], style: GoogleFonts.aBeeZee(
                  fontSize: 10, color: Colors.black.withOpacity(0.5))),
                  Kwidth1,
            Text(
              widget.ChatTime,
              style: GoogleFonts.aBeeZee(
                  fontSize: 10, color: Colors.black.withOpacity(0.5)),
            ),
            widget.data['read'] == false
                ? Icon(
                    Icons.check,
                    size: 16,
                    color: HomescreenColor,
                  )
                : Icon(
                    Icons.done_all,
                    size: 16,
                    color: HomescreenColor,
                  )
          ],
        )
      ],
    );
  }
}
