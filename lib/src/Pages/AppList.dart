import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppList extends StatefulWidget {
  var apps = [];
  var title = "";

  AppList({this.apps,this.title});

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  var apps = [];

  @override
  void initState() {
    apps = widget.apps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          WidgetHelper.getAppBar(context),
          WidgetHelper.getHeader("List of", widget.title, context),
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total ${apps.length}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ),
          SizedBox(height: 30),
          ...getUsers()
        ]))));
  }

  List<Widget> getUsers() {
    return List.generate(
      apps.length,
      (index) {
        var colors = [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.orange,
          Colors.pink,
          Colors.purple
        ];
        var subTitle = apps[index]["packageName"];
        var title = subTitle;
        try {
          title = apps[index]["appName"];
          if(title==null){
            throw Exception();
          }
        } catch (e) {
          title = subTitle.toString().split(".");
          title = title[title.length - 1];
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 7.5, right: 10),
          child: ListTile(
            onTap: (){
              launch("https://play.google.com/store/apps/details?id=${subTitle}");
            },
            leading: CircleAvatar(
              backgroundColor: colors[index % colors.length],
              child: Text(title[0].toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            title: Text(title),
            subtitle: Text( subTitle),
                 trailing:Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
         ,
          ),
        );
      },
    );
  }
}
