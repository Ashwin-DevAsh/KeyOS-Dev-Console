import 'dart:async';

import 'package:DevConsole/src/Context/Api.dart';
import 'package:DevConsole/src/Context/Devices.dart';
import 'package:DevConsole/src/Context/UserDetails.dart';
import 'package:DevConsole/src/Context/Users.dart';
import 'package:DevConsole/src/Helpers/ApiHelper.dart';
import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:DevConsole/src/Pages/EnrolledUsers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'DeviceList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> refresh() async {
    await ApiHelper.getDevices(context);
    setState(() {});
    return;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: getDrawer(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () {
              SystemNavigator.pop();
            },
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        getHeader(),
                        SizedBox(height: 40),
                        getGreetings(),
                        SizedBox(height: 40),
                        getTileContainer(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget getGreetings() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Hey ${UserDetails.admin["name"].substring(0, 3)},",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "this is your users",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 70),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total ${Devices.allDevices.length}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 7.5),
                    Container(
                      width: 75,
                      height: 2,
                      color: Colors.black,
                    )
                  ],
                ),
              ],
            )
          ])),
    );
  }

  Widget getTileContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: GridView.count(
        padding: EdgeInsets.only(bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          getCard(Colors.green, "Active", Devices.activeDevices,
              Icons.offline_bolt),
          getCard(Colors.red, "InActive", Devices.inactiveDevices,
              Icons.power_off_rounded),
          getCard(Colors.purple, "visited", Devices.justInstalled,
              Icons.download_done_outlined)
        ],
      ),
    );
  }

  Widget getCard(color, title, deviceList, icon) {
    var width = (MediaQuery.of(context).size.width - 40) / 2;
    try {
      width = (width * (deviceList.length / Devices.allDevices.length));
    } catch (e) {}
    return Padding(
      padding: const EdgeInsets.all(7.5),
      child: GestureDetector(
        onTap: () {
          RouteHelper.navigate(
              context, DeviceList(devices: deviceList, title: title));
        },
        child: Container(
          child: Card(
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2,
                    width: width,
                    color: color,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      icon,
                      color: color,
                    ),
                  ),
                  Expanded(
                    child: Center(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${deviceList.length} Devices",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getHeader() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                if (scaffoldKey.currentState.isDrawerOpen)
                  scaffoldKey.currentState.openEndDrawer();
                else {
                  scaffoldKey.currentState.openDrawer();
                }
              },
              child: Image(
                image: Image.asset("lib/src/Assets/Images/menu.png").image,
                width: 40,
              ),
            )
          ],
        ));
  }

  Drawer getDrawer() {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, bottom: 20, left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: Image.asset(
                                  "lib/src/Assets/Images/appIcon512.png")
                              .image,
                          height: 80,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Connected",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 7.5),
                          child: Text(
                            "Server Address ${Api.ipAddress}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: Icon(MaterialIcons.question_answer),
                        title: Text("Execute Query"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(MaterialIcons.date_range),
                        title: Text("Data Migration"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 25, bottom: 15),
                  child: Text("Enrolled",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),
                      )),
                ),
                ListTile(
                  leading: Icon(MaterialIcons.people),
                  title: Text("View all"),
                  onTap: () {
                    Navigator.of(context).pop();
                    RouteHelper.navigate(context, EnrolledUsers());
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    Users.users.length > 8 ? 8 : Users.users.length,
                    (index) => WidgetHelper.getUserTile(
                        Users.users[index], index, context)),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
