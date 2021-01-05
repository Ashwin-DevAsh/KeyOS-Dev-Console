import 'package:DevConsole/src/Context/Users.dart';
import 'package:DevConsole/src/Helpers/WidgetHelper.dart';
import 'package:flutter/material.dart';

class EnrolledUsers extends StatefulWidget {
  @override
  _EnrolledUsersState createState() => _EnrolledUsersState();
}

class _EnrolledUsersState extends State<EnrolledUsers> {
  var searchBarContoller = TextEditingController();

  void search() {
    users = [];
    Users.users.forEach((element) {
      if (element["email"]
          .toString()
          .toLowerCase()
          .contains(this.searchBarContoller.text.toLowerCase())) {
        users.add(element);
      }
    });
  }

  var users = [];

  @override
  void initState() {
    users.addAll(Users.users);
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
            WidgetHelper.getHeader("List of", "Enrolled Users", context),
            WidgetHelper.getSearchBar(
                searchBarContoller,
                () => setState(() {
                      search();
                    })),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total ${users.length}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ]),
        ),
      ),
    );
  }

  List<Widget> getUsers() {
    return List.generate(
      users.length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 7.5, right: 10),
        child: WidgetHelper.getUserTile(users[index], index, context,
            showArrow: true),
      ),
    );
  }
}
