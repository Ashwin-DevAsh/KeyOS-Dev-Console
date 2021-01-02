import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WidgetHelper {
  static Widget getAppBar(context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Icon(Icons.arrow_back_ios, color: Colors.black.withOpacity(0.9)),
          ],
        ),
      ],
    );
  }

  static Widget getUserTile(email,count,index){
    var colors = [Colors.red,Colors.blue,Colors.green,Colors.orange,Colors.pink,Colors.purple];
    return ListTile(
      leading: CircleAvatar(backgroundColor: colors[index%colors.length],child: Text(email[0],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
      title: Text(email,style: TextStyle(),),
      subtitle: Text( "No of Devices ${count}"),
    );
  }


  static Widget getHeader(title,subtitle,context) {
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
