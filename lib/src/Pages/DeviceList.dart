import 'dart:ffi';

import 'package:DevConsole/src/Context/Devices.dart';
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
  var searchBarContoller = TextEditingController();
  var devices = [];

  @override
  void initState() {
    print(Devices.activeDevices);

    devices.addAll(widget.devices);
    super.initState();
  }

  void search() {
    this.devices = [];
    widget.devices.forEach((element) {
      var isValid = element["brand"]
              .toString()
              .toLowerCase()
              .contains(this.searchBarContoller.text.toLowerCase()) ||
          element["model"]
              .toString()
              .toLowerCase()
              .contains(this.searchBarContoller.text.toLowerCase());
      if (isValid) {
        print(element);
        devices.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            WidgetHelper.getAppBar(context),
            WidgetHelper.getHeader(
                "List of", "${widget.title} devices", context),
            WidgetHelper.getSearchBar(
                searchBarContoller,
                () => setState(() {
                      search();
                    })),
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
        children:
            List.generate(devices.length, (index) => getCard(devices[index])),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  device["brand"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 12.5),
                                ),
                                 device["isonline"]?   Padding(
                                      padding: const EdgeInsets.only(bottom:7.5),
                                      child: Material(
                                        elevation: 2,
                                            borderRadius:BorderRadius.circular(5),

                                                                              child: Container(
                                          height:10,
                                          width:10,
                                          decoration:BoxDecoration(
                                            borderRadius:BorderRadius.circular(5),
                                            color:Colors.red.withOpacity(0.75)
                                          )
                                        ),
                                      ),
                                    ):Center()
                              ],
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
}
