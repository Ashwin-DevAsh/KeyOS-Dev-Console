import 'package:DevConsole/src/Context/Devices.dart';
import 'package:DevConsole/src/Helpers/Routehelper.dart';
import 'package:DevConsole/src/Pages/DeviceList.dart';
import 'package:flutter/material.dart';

class WidgetHelper {
  static Widget getAppBar(context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            SizedBox(width: 22.5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black.withOpacity(0.9),
                key: UniqueKey(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget getUserTile(object, index, context, {showArrow = false}) {
    var colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.pink,
      Colors.purple
    ];
    return ListTile(
      onTap: () {
        var devices = [];
        (Devices.activeDevices + Devices.inactiveDevices).forEach((element) {
          try {
            if (object["deviceid"]
                .toString()
                .split(",")
                .contains(element["deviceid"])) {
              devices.add(element);
            }
          } catch (e) {}
        });
        RouteHelper.navigate(
            context, DeviceList(devices: devices, title: "Registred"));
      },
      leading: CircleAvatar(
        backgroundColor: colors[index % colors.length],
        child: Text(object["email"][0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      title: Text(
        object["email"],
        style: TextStyle(),
      ),
      subtitle: Text("No of Devices ${object["devicescount"]}"),
      trailing: showArrow
          ? Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          : null,
    );
  }

  static Widget getHeader(title, subtitle, context) {
    return Container(
      key: UniqueKey(),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 30,
                )),
            SizedBox(height: 10),
            Text(subtitle,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  static Widget getSearchBar(searchBarContoller, searchFunction) {
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
                  controller: searchBarContoller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 40, left: 20),
                      hintText: "Serach Devices",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                searchFunction();
              },
              child: Material(
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
                  )),
            )
          ],
        ),
      ),
    );
  }

  static Image getAndroidIcon(sdk, height) {
    print(sdk);
    double imageHeight = height.toDouble();
    String imagePath(version) =>
        "lib/src/Assets/Images/androidIcon/android$version.png";
    if (sdk == "21" || sdk == "22") {
      return Image(
        image: Image.asset(imagePath(5)).image,
        height: imageHeight,
      );
    } else if (sdk == "23") {
      return Image(
        image: Image.asset(imagePath(6)).image,
        height: imageHeight,
      );
    } else if (sdk == "25") {
      return Image(
        image: Image.asset(imagePath(7)).image,
        height: imageHeight,
      );
    } else if (sdk == "26") {
      return Image(
        image: Image.asset(imagePath(8)).image,
        height: imageHeight,
      );
    } else if (sdk == "27") {
      return Image(
        image: Image.asset(imagePath(9)).image,
        height: imageHeight,
      );
    } else if (sdk == "28") {
      return Image(
        image: Image.asset(imagePath(10)).image,
        height: imageHeight,
      );
    } else if (sdk == "29") {
      return Image(
        image: Image.asset(imagePath(11)).image,
        height: imageHeight,
      );
    }
    return Image(
      image: Image.asset(imagePath(5)).image,
      height: 80,
    );
  }
}
