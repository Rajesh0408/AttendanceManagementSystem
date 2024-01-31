import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'logIn_faculty.dart';
import 'logIn_student.dart';
import 'main.dart';
import 'constants/colours.dart';



class FacultyStudent extends StatefulWidget {
  @override
  FacultyStudentState createState() => FacultyStudentState();
}

class FacultyStudentState extends State<FacultyStudent> {
  // Function to handle tap on Faculty image
  void onFacultyTap() {
    print("Faculty tapped");
    // Add your desired actions for Faculty tap here
  }

  // Function to handle tap on Student image
  void onStudentTap() {
    print("Student tapped");
    // Add your desired actions for Student tap here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Attendance Manager'),
        backgroundColor: AppColor.appbar,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Choose your role",
                style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic)),
            SizedBox(height: 40),
            // Faculty image with onTap
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPageFaculty())
                );
              },
              child: Column(
                children: [
                  Text("\t Faculty", style: TextStyle(fontSize: 30.0)),
                  SizedBox(height: 20),
                  Image.asset(
                    'lib/assets/faculty.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
            SizedBox(height: 70),
            // Student image with onTap
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPageStudent())
                );
              },
              child: Column(
                children: [
                  Text("\t Student", style: TextStyle(fontSize: 30.0)),
                  SizedBox(height: 20),
                  Image.asset(
                    'lib/assets/student.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}