import 'package:chat_application/config/Routers/routers.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/initialise.dart';
import 'package:chat_application/features/Externals/DataSource/Platform_repository_imp.dart/PlatformdataSource.imp.dart';
import 'package:chat_application/features/presentation/Cubit/Auth/auth_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/Chat/chat_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/Profile/profile_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/RegisterUser/user_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/UploadFiles/upload_files_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/search/search_cubit.dart';
import 'package:chat_application/features/presentation/pages/AuthScreens/SignUppage.dart';
import 'package:chat_application/features/presentation/pages/AuthScreens/LoginPage.dart';
import 'package:chat_application/features/presentation/pages/Home/Homescreen.dart';
import 'package:chat_application/features/presentation/widgets/Loding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Injecion_container.dart' as di;



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await di.Getit<IntialiseUseCase>().call();
  FirebaseMessaging.onBackgroundMessage(backgoundmessages);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> backgoundmessages(RemoteMessage message)async{
  await Firebase.initializeApp(); 
    await PlatoformDataSourceImp().ShowNotification(message);

} 
class MyApp extends StatefulWidget {
  static const String start = "./ForPractice:)";
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.Getit<AuthCubit>()..Ready(context)),
          BlocProvider(create: (_) => di.Getit<UserCubit>()),
          BlocProvider(create: (_) => di.Getit<ProfileCubit>()),
          BlocProvider(create: (_) => di.Getit<SearchCubit>()),
          BlocProvider(create: (_) => di.Getit<ChatCubit>()),
          BlocProvider(create: (_) => di.Getit<UploadFilesCubit>()),
        ],
        child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Chat_application',
            theme: ThemeData(
              iconTheme: IconThemeData(color: Colors.white),
              primaryColor: Colors.white,
              primaryTextTheme: TextTheme(
              titleSmall: GoogleFonts.aBeeZee(),
              bodyMedium: GoogleFonts.aBeeZee(),
              bodyLarge: GoogleFonts.aBeeZee()),
              primarySwatch:Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (set) => GenerateRoutes(set),
            home:BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case  Authloading:
                    return LoadingScreen();

                  case AccessDenied:
                     return LoginPage();

                  case AccessGranted:
                    return MainHomePage();
                  
                  default:
                     return SignUpPage();
                }
              },
            )));
  }
}
