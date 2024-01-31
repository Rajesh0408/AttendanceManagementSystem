import 'package:flutter/material.dart';
import 'package:myapp/listClass.dart';
import 'constants/colours.dart';
import 'AdvisorMainPage.dart';
import 'NavBar.dart';
import 'absentIntimation.dart';
import 'listClassViewAttendance.dart';
import 'logIn_faculty.dart';
import 'main.dart';

class HomePageFaculty extends StatefulWidget {
  String? userId;
  bool? isfaculty;
  String? name;
  HomePageFaculty(this.userId, this.isfaculty, this.name, {super.key});

  @override
  State<HomePageFaculty> createState() => _HomePageFacultyState();
}

class _HomePageFacultyState extends State<HomePageFaculty> {
  bool? isfaculty;
  String? userId;
  String? name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = widget.userId;
    name= widget.name;
    isfaculty = widget.isfaculty;
    print(isfaculty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white60,
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
                          listClass(userId ?? "", isfaculty ?? false, name),
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
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text(
                        'Take Attendance ',
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
                      builder: (context) => listClassViewAttendance(
                          userId ?? "", isfaculty ?? false),
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
                        'View Attendance ',
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
                      size: 40.0, // Set the size as per your requirement
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
                          absentIntimation(userId ?? "", isfaculty ?? false),
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
                      padding: EdgeInsets.only(left: 90.0),
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
          if (!isfaculty!)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdvisorMainPage(userId ?? "", isfaculty ?? false),
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
                          'My Students ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      ImageIcon(
                        AssetImage(
                          'lib/assets/icons/students.png',
                        ),
                        size: 70.0, // Set the size as per your requirement
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
