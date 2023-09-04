import 'dart:io';
import 'package:chat_application/config/constants/constants.dart';
import 'package:chat_application/features/presentation/pages/Home/Homescreen.dart';
import 'package:chat_application/features/presentation/widgets/customtextwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Domain/Entity/User/user_entity.dart';
import '../../Cubit/RegisterUser/user_cubit.dart';

enum Parts { first, second }

class GetPic extends StatefulWidget {
  static const String FillDetails = "GetDetailsScreen";
  GetPic({
    Key? key,
    required this.name,
    required this.Email,
    required this.password,
  }) : super(key: key);
  final String name;
  final String Email;
  final String password;

  @override
  State<GetPic> createState() => _GetPicState();
}

class _GetPicState extends State<GetPic> {
  XFile? imgfile;

  Parts parts = Parts.first;

  _SignUpuser(BuildContext context, File file) {
    final user = UserEntity(
      online: true,
        DeviceToken: '',
        name: widget.name,
        uid: '',
        emailaddress: widget.Email,
        date: DateTime.now().toString(),
        profileurl: '',
        age: int.parse(_Agcontroller.text.trim()),
        about: _AboutController.text.trim());
    BlocProvider.of<UserCubit>(context)
        .SignUpUser(user, widget.password, file)
        .then((value) {
      Navigator.of(context).pushReplacementNamed(MainHomePage.Homescreen);
    });
  }

  _pickimagr(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: source);
    if (img != null) {
      setState(() {
        imgfile = img;
      });
    }
  }

  final _AboutController = TextEditingController();
  final _Agcontroller = TextEditingController();

  final fomkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HomescreenColor,
        body: SafeArea(
            child: Stack(
          children: [
            Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Almost There !",
                  style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 30),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                  child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(100))),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Kheight30,
                          Kheight20,
                          if (parts == Parts.first)
                            Container(
                              child: Column(
                                children: [
                                  ClipRect(
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 160,
                                          backgroundImage: imgfile == null
                                              ? AssetImage(
                                                  "assets/profile-pic.jpeg")
                                              : FileImage(File(imgfile!.path))
                                                  as ImageProvider,
                                        ),
                                        Positioned(
                                            left: 50,
                                            top: 30,
                                            child: IconButton(
                                                onPressed: () {
                                                  _pickimagr(
                                                      ImageSource.gallery);
                                                },
                                                icon: Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 30,
                                                )))
                                      ],
                                    ),
                                  ),
                                  Kheigth10,
                                  Text(
                                    "SetUp a ProfilePic",
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.black, fontSize: 30),
                                  ),
                                  Kheigth10,
                                  Text(
                                    "The Profile picture will be Public",
                                    style: GoogleFonts.actor(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 15,
                                    ),
                                  ),
                                  Kheight30,
                                ],
                              ),
                            ),
                          if (parts == Parts.second)
                            Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: imgfile == null
                                        ? AssetImage("assets/profile-pic.jpeg")
                                        : FileImage(File(imgfile!.path))
                                            as ImageProvider,
                                  ),
                                  Kheigth10,
                                  Text(
                                    widget.name,
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.black, fontSize: 30),
                                  ),
                                  Kheight20,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: Form(
                                      key: fomkey,
                                      child: Column(
                                        children: [
                                          CustomTextfield(
                                              controller: _AboutController,
                                              hinttext: "About",
                                              obsecure: false,
                                              icons: Icons.info_outline),
                                          Kheight20,
                                          CustomTextfield(
                                              controller: _Agcontroller,
                                              hinttext: "Age",
                                              obsecure: false,
                                              icons: Icons.person_4_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Kheight30,
                                  InkWell(
                                    onTap: () {
                                      if (fomkey.currentState!.validate()) {
                                        if (imgfile == null) {
                                          Showtoast("Profile Pic is not Set");
                                        } else {
                                          _SignUpuser(
                                              context, File(imgfile!.path));
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: HomescreenColor),
                                      child: Center(
                                        child: Text(
                                          "Finish Up",
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Kheight20
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  activeColor: HomescreenColor,
                                  value: Parts.first,
                                  groupValue: parts,
                                  onChanged: (val) {
                                    setState(() {
                                      parts = val!;
                                    });
                                  }),
                              Radio(
                                  activeColor: HomescreenColor,
                                  value: Parts.second,
                                  groupValue: parts,
                                  onChanged: (val) {
                                    setState(() {
                                      parts = val!;
                                    });
                                  }),
                            ],
                          ),
                          Kheight20,
                         parts == Parts.second?  SizedBox(): InkWell(
                            onTap: () {
                              if (imgfile!=null) {
                                  setState(() {
                                parts = Parts.second;
                              });
                              }else{
                                Showtoast('Profile pic is not set');
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: HomescreenColor,
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Center(
                                child: Text('Next',style: GoogleFonts.aBeeZee(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.2,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        )));
  }
}
