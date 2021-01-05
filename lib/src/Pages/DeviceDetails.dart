import 'package:DevConsole/src/Helpers/ApiHelper.dart';
import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:DevConsole/src/Pages/AppList.dart';
import 'package:DevConsole/src/Pages/CallBlocker.dart';
import 'package:DevConsole/src/Pages/Webfilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceDetails extends StatefulWidget {
  var device = {};
  DeviceDetails({this.device});

  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiHelper.getDeviceConfig(widget.device["deviceid"], context),
        builder: (context, apiData) {
          if (!apiData.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          if (apiData.hasError) {}

          if (apiData.data["result"] != "success") {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Failed!"),
            ));
          }

          var config = apiData.data["deviceConfig"];
          if (config == null) {
            return Center(
              child: Text(
                "Not configured",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          }
          var basicSettings = config["basicSettings"];
          var calls = config["calls"];
          var webFilter = config["webFilter"];

          print(config);
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  getProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      getBigListTile(
                          title: "Device ID",
                          subtitle: widget.device["deviceid"],
                          icon: Icons.mobile_friendly),
                      getBigListTile(
                          title: "Password",
                          subtitle: config["password"].toString(),
                          icon: MaterialIcons.lock_outline),
                      getBigListTile(
                          title: "Email",
                          subtitle: config["recoveryEmail"].toString(),
                          icon: MaterialIcons.mail_outline),
                      Divider(),
                      getNormalListTile(
                          title: "wifi",
                          icon: MaterialIcons.wifi,
                          trailing: basicSettings["wifi"],
                          onClick: () {}),
                      getNormalListTile(
                          title: "sound",
                          trailing: basicSettings["sound"],
                          icon: MaterialIcons.volume_up,
                          onClick: () {}),
                      getNormalListTile(
                          title: "Bluetooth",
                          trailing: basicSettings["bluetooth"],
                          icon: MaterialIcons.bluetooth,
                          onClick: () {}),
                      getNormalListTile(
                          title: "Orientation",
                          icon: MaterialIcons.rotate_left,
                          trailing: basicSettings["orientation"],
                          onClick: () {}),
                      Divider(),
                      ListTile(
                          leading: Icon(MaterialIcons.notifications),
                          title: Text(
                            "Notification Panel",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          trailing: Switch(
                            value: basicSettings["notificationPanel"],
                            onChanged: (_) {},
                            activeColor: Colors.green,
                          )) //Icon(CupertinoIcons.forward),
                      ,
                      Divider(),
                      getBigListTile(
                          title: "Apps",
                          subtitle:
                              "Allowed ${config["allowedApps"].length} Apps",
                          icon: MaterialIcons.apps,
                          onClick: () {
                            RouteHelper.navigate(
                                context,
                                AppList(
                                  apps: config["allowedApps"],title: "Allowes Apps",
                                ));
                          },
                          showArrow: true),
                      getBigListTile(
                          title: "Edited Apps",
                          subtitle:
                              "Edited ${config["editedApps"].length} Apps",
                          icon: MaterialIcons.edit,
                          onClick: () {
                            RouteHelper.navigate(
                                context,
                                AppList(
                                  apps: config["editedApps"],title: "Edited Apps",
                                ));
                          },
                          showArrow: true),
                      getBigListTile(
                          title: "Service",
                          subtitle:
                              "Allowed ${config["allowedServices"].length} Services",
                          icon: MaterialIcons.settings,
                          onClick: () {
                            RouteHelper.navigate(
                                context,
                                AppList(
                                  apps: config["allowedServices"],title: "Allowes Services",
                                ));
                          },
                          showArrow: true),
                      getBigListTile(
                          onClick: () {
                            if (config["singleApp"] != null) {
                              launch(
                                  "https://play.google.com/store/apps/details?id=${config["singleApp"]["packageName"]}");
                            }
                          },
                          title: "Single app",
                          subtitle:
                              "${config["singleApp"] != null ? config["singleApp"]["packageName"] : "None"}",
                          icon: MaterialIcons.touch_app,
                          showArrow: true),
                      Divider(),
                      getBigListTile(
                          onClick: () {
                            RouteHelper.navigate(
                                context,
                                CallBlocker(
                                  calls: calls,
                                ));
                          },
                          title: "Call Blocker",
                          icon: MaterialIcons.call,
                          showArrow: true),
                      getBigListTile(
                          onClick: () {
                            RouteHelper.navigate(
                                context,
                                WebFilter(
                                  webfilter: webFilter,
                                ));
                          },
                          title: "Web Blocker",
                          icon: MaterialIcons.open_in_browser,
                          showArrow: true),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getNormalListTile({title, icon, trailing, onClick}) {
    return ListTile(
        onTap: onClick,
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        trailing: Text(trailing,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )) //Icon(CupertinoIcons.forward),
        );
  }

  Widget getBigListTile({title, subtitle, icon, onClick, showArrow = false}) {
    return ListTile(
        onTap: () {
          onClick != null && onClick();
        },
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
          ],
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: (subtitle != null) ? Text(subtitle) : null,
        trailing: showArrow ? Icon(CupertinoIcons.forward) : null);
  }

  Widget getProfile() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: WidgetHelper.getAndroidIcon(widget.device["sdk"], 50)),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.device["brand"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.device["model"] + " " + widget.device["versionname"],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
