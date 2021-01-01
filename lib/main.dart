import 'package:DevConsole/src/Pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/Pages/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.dark,
    //    statusBarIconBrightness: Brightness.dark,
    // ));
    return MaterialApp(
        theme: ThemeData(accentColor: Colors.black, primaryColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
