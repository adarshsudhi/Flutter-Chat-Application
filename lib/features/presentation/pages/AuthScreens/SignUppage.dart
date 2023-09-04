import 'package:chat_application/config/constants/constants.dart';
import 'package:chat_application/features/presentation/pages/AuthScreens/GetDetails.dart';
import 'package:chat_application/features/presentation/pages/AuthScreens/LoginPage.dart';
import 'package:chat_application/features/presentation/widgets/customtextwidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  static const String SignUp = "SignUP";
  SignUpPage({super.key});

  final _Emailcontroller = TextEditingController();
  final _Usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  final krey = GlobalKey<FormState>();

  _Clear() {
    _Emailcontroller.dispose();
    _Usernamecontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height / 2.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/SignUp.jpg"),
                          fit: BoxFit.cover)),
                ),
                Kheigth10,
                Text(
                  "Signup",
                  style: GoogleFonts.aboreto(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Kheigth10,
                Container(
                  child: Form(
                    key: krey,
                    child: Column(
                      children: [
                        CustomTextfield(
                            controller: _Usernamecontroller,
                            hinttext: "Username",
                            obsecure: false,
                            icons: Icons.person),
                        Kheight20,
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
                            if (krey.currentState!.validate()) {
                           /*   Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GetPic(
                                        name: _Usernamecontroller.text.trim(),
                                        Email: _Emailcontroller.text.trim(),
                                        password:
                                            _passwordcontroller.text.trim(),
                                      ))); */  
                                      Navigator.pushNamed(context, GetPic.FillDetails,
                                      arguments: GetPic( name: _Usernamecontroller.text.trim(),
                                        Email: _Emailcontroller.text.trim(),
                                        password:
                                            _passwordcontroller.text.trim(),));
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: HomescreenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Sign Up",
                              style: GoogleFonts.aBeeZee(color: Colors.white),
                            )),
                          ),
                        ),
                        Kheigth10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Alreay a member ?",
                              style: GoogleFonts.aBeeZee(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginPage.Login);
                                },
                                child: Text(
                                  "Sign in",
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
