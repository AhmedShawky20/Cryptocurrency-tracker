import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/resourses/Bloc_Observer.dart';
import 'package:Cryptocurrency/view/NavigationScreen.dart';
import 'package:Cryptocurrency/view/Onboarding.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'firebase_options.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Handle foreground messages
        handleMessage(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // Handle background messages
        handleMessage(message);
      });

      // Handle initial notification tap when app is terminated
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        handleMessage(initialMessage);
      }
      print(await FirebaseMessaging.instance.getToken());
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
void handleMessage(RemoteMessage message) {
  // Handle the FCM message data
  print('Received message: ${message.notification?.title}');




}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(), //..getUserData(FirebaseAuth.instance.currentUser!.uid),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home:FirebaseAuth.instance.currentUser !=null ? NavigationScreen(): OnBoarding(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
          );
        },
      ),
    );

  }
}
