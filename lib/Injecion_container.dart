import 'package:chat_application/features/Domain/Repository/Platform_Repository/Platform_Repository.dart';
import 'package:chat_application/features/Domain/UseCaseses/AgoraAPI_USeCase/GenerateTempToken_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/offline_user_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/onlin_user_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/notification/FirebaseNotification_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/CallNotificationRecieveUSeCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/Call_notificationUSeCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/MessageNotificationRecievedUseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/Notification_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Platform_useCase/initialise.dart';
import 'package:chat_application/features/Externals/DataSource/Platform_repository_imp.dart/PlatformDataSource.dart';
import 'package:chat_application/features/Externals/DataSource/Platform_repository_imp.dart/PlatformdataSource.imp.dart';
import 'package:chat_application/features/Externals/Repositoryimp/PlatformRepositoryImp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_application/features/Data/DataSource/RemoteDataSource/RemoteDataSourceimpl.dart';
import 'package:chat_application/features/Data/Repositoryimp/FirebaseRepositoryimp.dart';
import 'package:chat_application/features/Domain/Repository/Firebase_repository/Firebase_repository.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/GetHomeuser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/GetSingleUser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/Getchats_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/ReadUnreadmessages_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/SendMessage_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/Chat/UploadAttachedFile_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/GetCurrentUseruid_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/IsSignedIn_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SearchUser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SignIn_Usecase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SignOutUser_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/User/SignUp_Usecase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/profile/GetProfile_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/profile/UploadImageToStorage_UseCase.dart';
import 'package:chat_application/features/Domain/UseCaseses/Firebase_UseCase/profile/UploadprofileDetails_UseCase.dart';
import 'package:chat_application/features/presentation/Cubit/Auth/auth_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/Chat/chat_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/Profile/profile_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/RegisterUser/user_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/UploadFiles/upload_files_cubit.dart';
import 'package:chat_application/features/presentation/Cubit/search/search_cubit.dart';
import 'features/Data/DataSource/RemoteDataSource/RemoteDataSource.dart';

GetIt Getit = GetIt.instance;

Future<void> init() async {
  //Cubits
  Getit.registerFactory(() => AuthCubit(
        Getit.call(),
        Getit.call(),
      ));

  Getit.registerFactory(
    () => UserCubit(
      Getit.call(),
      Getit.call(),
      Getit.call(),
      Getit.call(),
      Getit.call()
    ),
  );

  Getit.registerFactory(
      () => ChatCubit(Getit.call(), Getit.call(), Getit.call(), Getit.call()));

  Getit.registerFactory(() => SearchCubit(Getit.call()));

  Getit.registerFactory(() => ProfileCubit(Getit.call(), Getit.call()));

  Getit.registerFactory(
      () => UploadFilesCubit(attachedFileuploadUseCase: Getit.call()));


  //Usecases
  Getit.registerLazySingleton(() => IsSignedInUseCase(Getit.call()));
  Getit.registerLazySingleton(() => SignUpUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => SignInUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => FirebaseNotification(repository: Getit.call()));


  Getit.registerLazySingleton(
      () => GetCurrentUserUIDUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => SearchUserUseCase(Getit.call()));
  Getit.registerLazySingleton(() => SignOutUsceCase(Getit.call()));
  Getit.registerLazySingleton(() => UploadImageUseCase(Getit.call()));
  Getit.registerLazySingleton(() => UploadUserDetailsUseCase(Getit.call()));
  Getit.registerLazySingleton(() => GetProfileUseCase(Getit.call()));
  Getit.registerLazySingleton(
      () => SendMessageUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => GetchatsUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(
      () => GetSingleUserUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(
      () => GetHomeUserUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(
      () => AttachedFileuploadUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(
      () => ReadUnreadMessagesUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => NotificationUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => CallNotifcationUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => MessageNotificationUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => IntialiseUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => GenerateTempTokenUseCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => CallRecievedUSeCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => onllineUserUsaeCase(repository: Getit.call()));
  Getit.registerLazySingleton(() => offineUserUsaeCase(repository: Getit.call()));


  //repositorys

  Getit.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryimpl(source: Getit.call()));

  Getit.registerLazySingleton<RemoteDataSource>(() => FirebaseRemoteSourceimpl(
      firestore: Getit.call(),
      firebaseAuth: Getit.call(),
      firebaseStorage: Getit.call()));

  Getit.registerLazySingleton<PlatFormRepository>(() => PlatFormRepositoryimp(source: Getit.call()));

  Getit.registerLazySingleton<PlatformDataSource>(() => PlatoformDataSourceImp());

  //Externels
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Getit.registerLazySingleton(() => auth);
  Getit.registerLazySingleton(() => firestore);
  Getit.registerLazySingleton(() => firebaseStorage);
  
}
