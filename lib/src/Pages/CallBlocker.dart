import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:flutter/material.dart';

class CallBlocker extends StatefulWidget {
  var calls;

  CallBlocker({this.calls});

  @override
  _CallBlockerState createState() => _CallBlockerState();
}

class _CallBlockerState extends State<CallBlocker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetHelper.getAppBar(context),
              WidgetHelper.getHeader("KeyOS", "Call Blocker", context),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10),
                child: Column(
                  children: [
                    getListTile("Allow Calls", widget.calls['allowCalls']),
                    getListTile(
                        "Incoming Calls", widget.calls['allowIncoming']),
                    getListTile(
                        "Outgoing Calls", widget.calls['allowOutgoing']),
                    getListTile(
                        "Whitelist Calls", widget.calls['whitelistCalls']),
                    getListTile("automatice whitelist Calls",
                        widget.calls['automaticWhitelist']),
                    getListTile(
                        "Backlist Calls", widget.calls['blackListCalls']),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getListTile(title, value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing:
          Switch(value: value, onChanged: (_) {}, activeColor: Colors.green),
    );
  }
}
