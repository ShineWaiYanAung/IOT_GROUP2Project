import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iot_group2_app/RealTimeDataBase/loca_notification.dart';
import 'package:iot_group2_app/config/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api_message.dart';
import 'authentication/Presentation/pages/Home_Page.dart';
import 'authentication/Presentation/pages/dash_board.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  try {
    await Firebase.initializeApp();
    await FireBaseAPI().initNotifications();


    if (kDebugMode) {
      print('Firebase initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing Firebase: $e');
    }
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        cardColor: cardColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'SecondaryFont',
            color: titleTextColor,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 60,
          ),
          titleMedium: TextStyle(
            fontFamily: 'SecondaryFont',
            color: titleTextColor,
            letterSpacing: 4,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          titleSmall: TextStyle(
            color: cardColor
          ),
        ),
        useMaterial3: true,
      ),
      home: DashBoard()
    );
  }
  ///ProgressBar


}
