import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_application/config/constants/constants.dart';
import 'package:chat_application/features/presentation/Cubit/Profile/profile_cubit.dart';
import 'package:chat_application/features/presentation/widgets/Appbar.dart';

class ProFile extends StatefulWidget {
  static const String Profilescreen = '/profileSCreen';
  const ProFile({super.key});

  @override
  State<ProFile> createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  get() async {
    await BlocProvider.of<ProfileCubit>(context).Get();
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(
            backgroundColor: HomescreenColor,
            appBar: CustomAppbar("Searching...", Icons.arrow_back, context, () {
              Navigator.of(context).pop();
            }),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: radiuss()),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: HomescreenColor,
                          ),
                          Text(
                            "Searching....",
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is Getprofile) {
          return state.enitity.isEmpty
              ? Scaffold(
                  backgroundColor: Colors.white,
                  appBar:
                      CustomAppbar("No Data", Icons.arrow_back, context, () {
                    Navigator.of(context).pop();
                  }),
                  body: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: size.height,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: HomescreenColor,
                              borderRadius: radiuss(),
                              image: DecorationImage(
                                  image: AssetImage("assets/newno.jpg"),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                    ],
                  ),
                )
              : Scaffold(
                  backgroundColor: HomescreenColor,
                  appBar: CustomAppbar(
                      state.enitity[0].name.isEmpty
                          ? "User Name"
                          : state.enitity[0].name,
                      Icons.arrow_back,
                      context, () {
                    Navigator.of(context).pop();
                  }),
                  body: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                          color: Colors.white
                        ),
                        height: size.height,
                        width: size.width,
                        child: Column(
                          children: [
                            Kheight30,
                            CircleAvatar(
                              radius:100,
                              backgroundImage: CachedNetworkImageProvider(state.enitity[0].profileurl
                              ),
                            ),
                              Kheight30,
                              UserDetails(text: 'Name', Detail: state.enitity[0].name,iconData: Icons.person,),
                               Padding(
                                 padding: const EdgeInsets.only(left: 70,right: 70),
                                 child: Text('This is your username or pin. This name will be visible to Other Users',style: GoogleFonts.aBeeZee(fontSize: 10),),
                               ),
                               UserDetails(text: 'About', Detail: state.enitity[0].about,iconData: Icons.info_outline,),
                                UserDetails(text: 'Age', Detail: state.enitity[0].age.toString(),iconData: Icons.person_4_rounded,),
                                 UserDetails(text: 'Email', Detail: state.enitity[0].emailaddress,iconData: Icons.email,),
                          ],
                        ),
                      )
                    ],
                  )
                );
        }
        return Container();
      },
    );
  }
}

class UserDetails extends StatelessWidget {
  final String text;
  final String Detail;
  final IconData iconData;
  const UserDetails({
    Key? key,
    required this.text,
    required this.Detail,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
    
      leading: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Icon(iconData,size: 30,),
      ),
      title:Text(text,style: GoogleFonts.aBeeZee(fontSize: 10),),
      subtitle: Text(Detail,style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 17),),
    );
  }
}
