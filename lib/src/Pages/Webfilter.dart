import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:flutter/material.dart';

class WebFilter extends StatefulWidget {

  
  var webfilter;

  WebFilter({this.webfilter});

  @override
  _WebFilterState createState() => _WebFilterState();
}

class _WebFilterState extends State<WebFilter> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetHelper.getAppBar(context),
              WidgetHelper.getHeader("KeyOS", "Web Blocker", context),
              

              Padding(
                padding: const EdgeInsets.only(top:40.0,left:10),
                child: Column(
                  children: [
                      getListTile("Web filter", widget.webfilter['isEnabled']),
                      getListTile("blacklist websites", widget.webfilter['isBlacklistEnabled']),
                      getListTile("whitelist websites", widget.webfilter['isWhitelistEnabled']),
                      getListTile("block adult websites", widget.webfilter['shouldBlockAdultSites']),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

    Widget getListTile(title,value){
    return  ListTile(
                    title: Text(title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Switch(value: value,onChanged: (_){},activeColor: Colors.green),);
  }
}