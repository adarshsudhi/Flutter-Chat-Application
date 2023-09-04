import 'dart:io';
import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/presentation/Cubit/Profile/profile_cubit.dart';
import 'package:chat_application/features/presentation/widgets/Appbar.dart';
import 'package:chat_application/features/presentation/widgets/Externals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/constants/constants.dart';

class ProfileDetails extends StatefulWidget {
  static const ProfileDetailsScreen = '/ProfileDetails';
  ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  XFile? file;

  final _namecontroller = TextEditingController();

  final _Agecontroller = TextEditingController();

  final _Lebalcontroller = TextEditingController();

  Externals externals = Externals();

  Future<XFile?> _pickimage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    return file;
  }

  void _UploadDetails(File fileee) {
    final us = UserEntity(
      online: true,
      DeviceToken: '',
        name: _namecontroller.text.trim(),
        uid: '',
        emailaddress: '',
        date: DateTime.now().toString(),
        profileurl: '',
        age: int.parse(_Agecontroller.text.trim()),
        about: _Lebalcontroller.text.trim());

    BlocProvider.of<ProfileCubit>(context).Upload(us, fileee).then((value) {
      _clear();
    });
  }

  _clear() {
    _namecontroller.clear();
    _Lebalcontroller.clear();
    _Agecontroller.clear();
    setState(() {
      file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _Agecontroller.dispose();
    _Lebalcontroller.dispose();
    file;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppbar("Update Profile", Icons.arrow_back, context, () {
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: size.height / 1.180,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100))),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: ListView(
                  children: [
                    Kheigth10,
                    Container(
                        width: double.infinity,
                        height: size.height / 6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                          30,
                        )),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: file != null
                                    ? FileImage(File(file!.path))
                                    : AssetImage("assets/profile-pic.jpeg")
                                        as ImageProvider,
                              ),
                            ),
                            Positioned(
                              right: 60,
                              top: 45,
                              child: IconButton(
                                  onPressed: () async {
                                    XFile? image = await externals
                                        .pickimagee(ImageSource.gallery);
                                    if (image != null) {
                                      setState(() {
                                        file = image;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: HomescreenColor,
                                    size: 30,
                                  )),
                            )
                          ],
                        )),
                    Kheight30,
                    CustomProfileTextfom(
                      namecontroller: _namecontroller,
                      hint: "Name",
                    ),
                    Kheight30,
                    CustomProfileTextfom(
                        namecontroller: _Agecontroller, hint: "Age"),
                    Kheight30,
                    CustomProfileTextfom(
                        namecontroller: _Lebalcontroller, hint: "Bio"),
                    Kheight30,
                    InkWell(
                      onTap: () {
                        if (file != null &&
                            _namecontroller.text.isNotEmpty &&
                            _Agecontroller.text.isNotEmpty &&
                            _Lebalcontroller.text.isNotEmpty) {
                          _UploadDetails(File(file!.path));
                        } else {
                          Showtoast("Field is Empty");
                        }
                      },
                      child: Container(
                        height: 65,
                        width: 100,
                        decoration: BoxDecoration(
                            color: HomescreenColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileLoading) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Please Wait ",
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Kwidth1,
                                  CircularProgressIndicator(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ],
                              );
                            } else {
                              return Text(
                                "Update",
                                style: GoogleFonts.aBeeZee(color: Colors.white),
                              );
                            }
                          },
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomProfileTextfom extends StatelessWidget {
  final String hint;
  const CustomProfileTextfom({
    super.key,
    required TextEditingController namecontroller,
    required this.hint,
  }) : _namecontroller = namecontroller;

  final TextEditingController _namecontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _namecontroller,
      decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
