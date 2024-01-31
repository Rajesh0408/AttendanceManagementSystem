import 'package:flutter/material.dart';
import 'package:myapp/viewAttendanceForAdvisor.dart';


import 'EnrollStudent.dart';
import 'NavBar.dart';
import 'addCourseInput.dart';
import 'addStudent.dart';
import 'constants/colours.dart';

class AdvisorMainPage extends StatefulWidget {
  String userId;
  bool isfaculty;
  AdvisorMainPage(this.userId, this.isfaculty);

  @override
  State<AdvisorMainPage> createState() => _AdvisorMainPageState();
}

class _AdvisorMainPageState extends State<AdvisorMainPage> {
  String userId='';
  bool? isfaculty;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty=widget.isfaculty;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.violet,
        title: Text('Attendance Manager'),
      ),
      //drawer: NavBar(userId,isfaculty!),
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(20.0),
            height: 150,

            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
              //hoverColor: AppColor.card,
              tileColor: AppColor.lightViolet,
              title:  const Padding(
                padding: EdgeInsets.only(left: 85.0),
                child: Center(
                  child: Row(
                        children: [
                          Text('Add course  ',style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.black),),

                          ImageIcon(
                            AssetImage(
                              'lib/assets/icons/addCourses.png',
                            ),
                            size: 40.0,
                            color: Colors.black,// Set the size as per your requirement
                            // color: Colors.white, // Set the color as per your requirement
                          ),
                           ],
                      ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => addCourseInput(userId,isfaculty!),));
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20.0),
            height: 150,
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
              //hoverColor: AppColor.card,
              tileColor: AppColor.lightViolet,
              title: const Padding(
                padding: EdgeInsets.only(left: 85.0),
                child: Center(
                  child: Row(
                    children: [
                      Text('Enroll student  ',style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,fontSize: 22.0, color: Colors.black),),

                      ImageIcon(
                        AssetImage(
                          'lib/assets/icons/courses.png',
                        ),
                        size: 40.0,
                        color: Colors.black,// Set the size as per your requirement
                        // color: Colors.white, // Set the color as per your requirement
                      ),
                        ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnrollStudent(userId)));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 150,
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
              //hoverColor: AppColor.card,
              tileColor: AppColor.lightViolet,
              title:  const Padding(
                padding: EdgeInsets.only(left: 75.0),
                child: Center(
                  child: Row(
                    children: [
                      Text('View Attendance ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.black),),
                      ImageIcon(
                        AssetImage(
                          'lib/assets/icons/eye.png',
                        ),
                        size: 25.0, // Set the size as per your requirement
                        color: Colors.black, // Set the color as per your requirement
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAttendanceForAdvisor( userId),));
              },
            ),
          ),
        ],
      )
      // GridView(gridDelegate:
      // SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2, mainAxisSpacing: 0, crossAxisSpacing: 0),
      //   children: [
      //     GestureDetector(
      //       onTap: () {
      //         //String courseCode= listData![index]['course_code'];
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => takeAttendance(courseCode,userId)),
      //         // );
      //       },
      //       child: Container(
      //         margin: EdgeInsets.all(20.0),
      //         padding: EdgeInsets.all(20.0),
      //         height: 50.0,
      //         decoration: BoxDecoration(
      //           color: AppColor.button,
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         child: Text('Add Student', style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
      //           textAlign: TextAlign.center,),
      //
      //       ),
      // ),
      //     GestureDetector(
      //       onTap: () {
      //         //String courseCode= listData![index]['course_code'];
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => takeAttendance(courseCode,userId)),
      //         // );
      //       },
      //       child: Container(
      //         margin: EdgeInsets.all(20.0),
      //         padding: EdgeInsets.all(20.0),
      //         height: 50.0,
      //         decoration: BoxDecoration(
      //           color: AppColor.button,
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         child: Text('Add ', style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
      //           textAlign: TextAlign.center,),
      //
      //       ),
      //     ),
      //   ],
      // )
    );
  }
}
