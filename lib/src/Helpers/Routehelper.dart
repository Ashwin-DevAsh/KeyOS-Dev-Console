import 'package:flutter/cupertino.dart';

class RouteHelper {
  static navigate(context, page) {
    var route = CupertinoPageRoute(builder: (context) => page);
    Navigator.of(context).push(route);
  }

  static navigateReplace(context, page) {
    var route = CupertinoPageRoute(builder: (context) => page);
    Navigator.of(context).pushReplacement(route);
  }
}
