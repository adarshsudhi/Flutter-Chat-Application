import 'package:chat_application/features/Domain/Entity/User/user_entity.dart';
import 'package:chat_application/features/presentation/Cubit/Auth/auth_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/RegisterUser/user_cubit.dart';
import 'package:chat_application/features/presentation/pages/AuthScreens/SignUppage.dart';
import 'package:chat_application/features/presentation/pages/Home/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/constants.dart';
import '../../widgets/customtextwidget.dart';

class LoginPage extends StatelessWidget {
  static const String Login = "loginscreen";
  LoginPage({super.key});

  final _Emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  _Clear() {
    _Emailcontroller.clear();
    _passwordcontroller.clear();
  }

  _LogIN(BuildContext context) async {
    final user = UserEntity(
        online: true,
        DeviceToken: '',
        name: '',
        uid: '',
        emailaddress: _Emailcontroller.text.trim(),
        date: '',
        profileurl: '',
        age: 0,
        about: '');
    BlocProvider.of<UserCubit>(context)
        .SignInuser(user, _passwordcontroller.text.trim())
        .then((value) async {
      final isisgnedin =
          await BlocProvider.of<AuthCubit>(context).IsAuthentcated();
      if (isisgnedin == true) {
        _Clear();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainHomePage()));
      } else {
        _Clear();
        Showtoast("Authorization Revoked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height / 1.9,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/loginperson.jpg"),
                          fit: BoxFit.cover)),
                ),
                Kheigth10,
                Text(
                  "Login",
                  style: GoogleFonts.aboreto(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Kheigth10,
                Container(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        CustomTextfield(
                            controller: _Emailcontroller,
                            hinttext: "Email",
                            obsecure: false,
                            icons: Icons.email),
                        Kheight20,
                        CustomTextfield(
                            controller: _passwordcontroller,
                            hinttext: "Password",
                            obsecure: true,
                            icons: Icons.key),
                        Kheight20,
                        InkWell(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              _LogIN(context);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: HomescreenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                Center(child: BlocBuilder<UserCubit, UserState>(
                              builder: (context, state) {
                                if (state is UserLoading) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Please Wait",
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.white),
                                      ),
                                      Kwidth1,
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    ],
                                  );
                                } else {
                                  return Text(
                                    "Login",
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white),
                                  );
                                }
                              },
                            )),
                          ),
                        ),
                        Kheigth10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not Joined?",
                              style: GoogleFonts.aBeeZee(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, SignUpPage.SignUp);
                                },
                                child: Text(
                                  "Join Now",
                                  style:
                                      GoogleFonts.aBeeZee(color: Colors.indigo),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
