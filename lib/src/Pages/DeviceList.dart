import 'dart:ffi';

import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DeviceDetails.dart';

class DeviceList extends StatefulWidget {
  List devices = [];
  String title = "Active";
  DeviceList({this.devices, this.title});
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            WidgetHelper.getAppBar(context),
            WidgetHelper.getHeader("List of","${widget.title} devices",context),
            getSearchBar(),
            SizedBox(height: 50),
            getTileContainer()
          ]),
        ),
      ),
    );
  }

  Widget getTileContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: GridView.count(
        childAspectRatio: 2,
        padding: EdgeInsets.only(bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 1,
        children: List.generate(
            widget.devices.length, (index) => getCard(widget.devices[index])),
      ),
    );
  }

  Widget getCard(device) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
      child: GestureDetector(
        onTap: () {
          RouteHelper.navigate(context, DeviceDetails(device: device));
        },
        child: Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27.5),
            bottomRight: Radius.circular(27.5),
          ),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.25)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27.5),
                bottomRight: Radius.circular(27.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Center()),
                  WidgetHelper.getAndroidIcon(device["sdk"], 50),
                  Expanded(child: Center()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device["brand"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.5),
                            ),
                            SizedBox(height: 7.5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  device["model"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                SizedBox(width: 7),
                                Text(
                                  device["versionname"].replaceAll("KeyOS", ""),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.6)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ]),
                      Expanded(child: Center()),
                      GestureDetector(
                        onTap: () async {
                          await launch(
                              "https://www.google.com/search?q=${device["brand"]}+${device["model"]}");
                        },
                        child: Material(
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(27.5),
                              bottomRight: Radius.circular(25),
                            ),
                            color: Colors.black,
                            child: Container(
                              height: 40,
                              width: 80,
                              child: Center(
                                child: Icon(
                                  MaterialCommunityIcons.google,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 40),
      child: Material(
        borderOnForeground: false,
        color: Color(0xffefefef),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(27.5),
          topLeft: Radius.circular(27.5),
          bottomRight: Radius.circular(27.5),
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 55,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 40, left: 20),
                      hintText: "Serach Devices",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ),
            Material(
                elevation: 5,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27.5),
                  bottomRight: Radius.circular(27.5),
                ),
                color: Colors.black,
                child: Container(
                  height: 55,
                  width: 54,
                  child: Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  
}
