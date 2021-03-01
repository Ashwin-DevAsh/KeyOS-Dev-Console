import 'dart:convert';
import 'dart:io';
import 'package:DevConsole/src/Context/Devices.dart';
import 'package:DevConsole/src/Context/PrevCountState.dart';
import 'package:DevConsole/src/Context/UserDetails.dart';
import 'package:DevConsole/src/Context/Users.dart';
import 'package:DevConsole/src/Database/Databasehelper.dart';
import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Pages/Login.dart';
import 'package:DevConsole/src/Services/DatabaseService.dart';
import 'package:http/http.dart' as http;
import 'package:DevConsole/src/Context/Api.dart';
import 'package:sembast/sembast.dart';

class ApiHelper {
  static Future<dynamic> getDevices(context) async {
    var url = Api.url + "/getAllDevices";
    var response = await http.get(url, headers: {"token": UserDetails.token});
    var body = json.decode(response.body);
    checkSession(body, context);
    if (body["result"] == "success") {
      var prevCount = await DatabaseService.getPrevCount();

      PrevStateCount.activeDevicesCount = prevCount["activeDevicesCount"];
      PrevStateCount.inactiveDevicesCount = prevCount["inactiveDevicesCount"];
      PrevStateCount.allDevicesCount = prevCount["allDevicesCount"];
      PrevStateCount.justInstalledCount = prevCount["justInstalledCount"];

      Devices.loadData(body["devices"]);

      DatabaseService.updatePrevCount(
        allDevicesCount: Devices.allDevices.length,
        inactiveDevicesCount: Devices.inactiveDevices.length,
        justInstalledCount: Devices.justInstalled.length,
        activeDevicesCount: Devices.activeDevices.length
      );
      return (body["devices"]);
    } else {
      return (null);
    }
  }

  static Future<dynamic> login(email, password) async {
    email = email.replaceAll(" ", "");
    password = password.replaceAll(" ", '');
    var url = Api.url + "/adminLogin";
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    var body = json.decode(response.body);
    return (body);
  }

  static Future<dynamic> getDeviceConfig(deviceID, context) async {
    var url = Api.url + "/getDeviceConfig/$deviceID";
    var response = await http.get(url, headers: {"token": UserDetails.token});
    var body = json.decode(response.body);
    checkSession(body, context);
    return (body);
  }

  static Future<dynamic> getUsers(context) async {
    var url = Api.url + "/getUsers";
    var response = await http.get(url, headers: {"token": UserDetails.token});
    var body = json.decode(response.body);
    try{
        Users.users = body["users"];
        return (body);
    }catch(e){}
  }

  static void checkSession(body, context) async {
    if (body["result"] == "invalid admin") {
      await StoreRef.main().record("token").delete(DataBaseHelper.db);
      RouteHelper.navigate(context, Login());
    }
  }
}
