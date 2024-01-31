import 'package:flutter/material.dart';
import 'package:myapp/listClass.dart';
import 'ViewFormsByStudent.dart';
import 'constants/colours.dart';
import 'AdvisorMainPage.dart';
import 'NavBar.dart';
import 'absentIntimation.dart';
import 'absentIntimationStudent.dart';
import 'main.dart';
import 'overallAttendanceStudent.dart';

class HomePageStudent extends StatefulWidget {
  String? userId;
  bool? isfaculty;
  String? name;
  HomePageStudent(this.userId, this.isfaculty,this.name, {super.key});

  @override
  State<HomePageStudent> createState() => _HomePageStudentState();
}

class _HomePageStudentState extends State<HomePageStudent> {
  bool? isfaculty;
  String? userId;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = widget.userId;
    isfaculty = widget.isfaculty;
    name = widget.name;
    print("userid in home page:" + userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.appbar,
      //   title: const Text('Attendance Manager'),
      // ),
      //drawer: NavBar(userId ?? "", isfaculty ?? false),
      body: ListView(
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 11),
                    child: Text(
                      '$name',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 240,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  child: const Icon(Icons.logout),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          overallAttendanceStudent(userId ?? ""),
                    ));
              },
              child: Container(
                height: 130,
                width: 200,
                decoration: const BoxDecoration(
                    color: AppColor.orange,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text(
                        'Overall Attendance ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    ImageIcon(
                      AssetImage(
                        'lib/assets/icons/user.png',
                      ),
                      size: 60.0, // Set the size as per your requirement
                      // color: Colors.white, // Set the color as per your requirement
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          listClass(userId ?? "", isfaculty ?? false,name),
                    ));
              },
              child: Container(
                height: 130,
                width: 200,
                decoration: const BoxDecoration(
                    color: AppColor.turquoise,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text(
                        'Daily Attendance ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    ImageIcon(
                      AssetImage(
                        'lib/assets/icons/user.png',
                      ),
                      size: 60.0, // Set the size as per your requirement
                      // color: Colors.white, // Set the color as per your requirement
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          absentIntimationStudent(userId ?? "", isfaculty!, name!),
                    ));
              },
              child: Container(
                height: 130,
                width: 200,
                decoration: const BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 90.0),
                      child: Text(
                        'Take Form ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    ImageIcon(
                      AssetImage(
                        'lib/assets/icons/form.png',
                      ),
                      size: 50.0, // Set the size as per your requirement
                      // color: Colors.white, // Set the color as per your requirement
                    ),
                  ],
                ),
              ),
            ),
          ),
          //if (isfaculty==true)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewFormsByStudent(userId ?? "", isfaculty ?? false),
                    ));
              },
              child: Container(
                height: 130,
                width: 200,
                decoration: const BoxDecoration(
                    color: AppColor.violet,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 80.0),
                      child: Text(
                        'View Forms ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    ImageIcon(
                      AssetImage(
                        'lib/assets/icons/eye.png',
                      ),
                      size: 50.0, // Set the size as per your requirement
                      // color: Colors.white, // Set the color as per your requirement
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPageFaculty(),
                        ));
                  },
                  child: const Text('Logout')),
            ],
          );
        });
  }
}
