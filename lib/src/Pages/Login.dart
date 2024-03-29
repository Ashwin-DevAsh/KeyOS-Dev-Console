import 'dart:convert';
import 'dart:io';

import 'package:DevConsole/src/Context/Api.dart';
import 'package:DevConsole/src/Context/UserDetails.dart';
import 'package:DevConsole/src/Database/Databasehelper.dart';
import 'package:DevConsole/src/Helpers/AlertHelper.dart';
import 'package:DevConsole/src/Helpers/ApiHelper.dart';
import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sembast/sembast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  void login(email, password, context) async {
    AlertHelper.showLoadingDialog(context);
    var body = await ApiHelper.login(email, password);
    if (body["result"] == "success") {
      loginSuccess(body["admin"], body["token"]);
    } else {
      Navigator.of(context).pop();
      Future.delayed(Duration(seconds: 1), () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Login Failed!"),
        ));
      });
    }
  }

  void loginSuccess(admin, token) async {
    UserDetails.admin = admin;
    UserDetails.token = token;
    await ApiHelper.getDevices(context);
    await ApiHelper.getUsers(context);
    await StoreRef.main().record("token").add(DataBaseHelper.db, token);
    await StoreRef.main().record("admin").add(DataBaseHelper.db, admin);

    RouteHelper.navigateReplace(context, Home());
  }

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
        },
        child: SafeArea(
          child: Builder(builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getHeader(),
                  Expanded(child: Center()),
                  getLoginComponents(),
                  Expanded(child: Center()),
                  Expanded(child: Center()),
                  getFooter(context)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getFooter(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(children: [
        SizedBox(width: 20),
        Text(
          "forgot Password?",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Expanded(child: Center()),
        GestureDetector(
          onTap: () {
            login(email.text, password.text, context);
          },
          child: Material(
            color: Color(0xff000000),
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Container(
              height: 50,
              width: 80,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ]),
    );
  }

  Widget getHeader() {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7.5),
                Container(width: 40, height: 2, color: Colors.black)
              ],
            ),
            SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7.5),
                Container(width: 50, height: 2)
              ],
            ),

            Expanded(child: Center()),
            //  Image(image:  AssetImage("lib/src/Assets/Images/appIcon512.png"),height: 50,)
          ],
        ),
      ),
    );
  }

  Widget getLoginComponents() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wellcome Back,",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Admin",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 80),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: email,
                    cursorColor: Colors.black,
                    decoration: new InputDecoration(hintText: "Email address"),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    cursorColor: Colors.black,
                    decoration: new InputDecoration(hintText: "Password"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
