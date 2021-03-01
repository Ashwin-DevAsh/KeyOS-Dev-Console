import 'package:DevConsole/src/Context/UserDetails.dart';
import 'package:DevConsole/src/Database/Appdatabase.dart';
import 'package:DevConsole/src/Database/Databasehelper.dart';
import 'package:DevConsole/src/Helpers/ApiHelper.dart';
import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Pages/Home.dart';
import 'package:DevConsole/src/Pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import '../Helpers/Routehelper.dart';
import 'Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadApp();
    super.initState();
  }

  void loadApp() async {
    await getDatabaseInstance();
    navigate();
  }

  void navigate() async {
    var token =
        await DataBaseHelper.store.record("token").exists(DataBaseHelper.db);
    if (token) {
        openHomePage();
    } else {
      Future.delayed(Duration(seconds: 1), () {
        RouteHelper.navigateReplace(context, Login());
      });
    }
  }

  void openHomePage() async {
    UserDetails.token =
        await StoreRef.main().record("token").get(DataBaseHelper.db);
    UserDetails.admin =
        await StoreRef.main().record("admin").get(DataBaseHelper.db);
    await ApiHelper.getDevices(context);
    await ApiHelper.getUsers(context);
    RouteHelper.navigateReplace(context, Home());
  }

  void loadData() async {}

  Future getDatabaseInstance() async {
    DataBaseHelper.db = await AppDatabase.instance.database;
    DataBaseHelper.store = StoreRef.main();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: Image.asset("lib/src/Assets/Images/appIcon512.png").image,
          width: 300,
        ),
      ),
    );
  }
}
