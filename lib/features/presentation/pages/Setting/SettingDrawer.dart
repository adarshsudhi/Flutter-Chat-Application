import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/config/constants/constants.dart';
import 'package:chat_application/features/presentation/Cubit/Profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Cubit/RegisterUser/user_cubit.dart';
import '../AuthScreens/LoginPage.dart';
import '../Editprofile/Editprofile.dart';
import '../Profile/Profile_Details.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
 

  void _SignOutUser() {
    BlocProvider.of<UserCubit>(context).SignOutuser().then((value) {
      Navigator.of(context).pushReplacementNamed(LoginPage.Login);
    });
  }

  bool notification = false;


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white,
          ), //BoxDecoration
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(child:CircularProgressIndicator(color: HomescreenColor,));
              } else if(state is ProfileFailed){
                return Text("Error 404");
              } else if (state is Getprofile){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                    radius: 35,
                    backgroundImage: CachedNetworkImageProvider(state.enitity[0].profileurl),
                  ),
                  Kwidth1,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.enitity[0].name,style: GoogleFonts.aBeeZee(fontSize: 18),),
                        Kheigth10,
                        Text(state.enitity[0].emailaddress,style: GoogleFonts.aBeeZee(fontSize: 15),),
                      ],
                    ),
                  )
                  ],
                );
              }else{
                 return Text('Error 404');
              }
               },
          ), //UserAccountDrawerHeader
        ),
        Kheight30,
        InkWell(
          onTap: () {
           // RouteToScreens(context, ProFile(), -1, 0);
           Navigator.pushNamed(context, ProFile.Profilescreen);
          },
          child: ListTile(
            title: Text(
              "View Profile",
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
            leading: Icon(Icons.person),
          ),
        ),
        Kheight30,
        InkWell(
          onTap: () {
           // RouteToScreens(context, ProfileDetails(), -1, 0);
           Navigator.pushNamed(context, ProfileDetails.ProfileDetailsScreen);
          },
          child: ListTile(
            title: Text(
              "Edit Profile",
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
            leading: Icon(Icons.edit_document),
          ),
        ),
        
        Kheight30,
        InkWell(
          onTap: () {
            _SignOutUser();
          },
          child: ListTile(
            title: Text(
              "Sign Out",
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
            leading: Icon(Icons.logout_outlined),
          ),
        ),
      ],
    );
  }
}
