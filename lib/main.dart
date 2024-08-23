import 'package:flutter/material.dart';
import 'package:iot_group2_app/config/theme.dart';

import 'authentication/Presentation/pages/dash_board.dart';

void main() {
  runApp(const MyApp());
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
      home: const DashBoard(),
    );
  }
  ///ProgressBar


}
