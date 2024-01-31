import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:myapp/listClass.dart';
import 'package:myapp/post/postCourseDetails.dart';
import 'package:myapp/post/postaddStudent.dart';
import 'package:myapp/takeAttendance.dart';
import 'constants/colours.dart';

class addStudent extends StatefulWidget{
  bool isfaculty;
  String? name;
   addStudent(this.isfaculty,this.name,{super.key});
  @override
  addStudentState createState() => addStudentState();
}

class addStudentState extends State<addStudent> {
  TextEditingController rollnoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool? isfaculty;
  String email='';
  String rollno ='';
  String name = '';
  String courseCode ='';
  String userId='';
  String? naam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isfaculty=widget.isfaculty!;
    naam = widget.name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: Text('Add Student'), ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            TextField(
              controller: rollnoController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                labelText:  'Enter the student roll number',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                labelText:  'Enter the student name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                labelText:  'Enter the student email id',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: double.infinity,
              height:60,
              onPressed: (){
                rollno = rollnoController.text;
                name = nameController.text;
                email= emailController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Student added successfully"),
                    duration: Duration(seconds: 2),
                  ),
                );
                postaddStudent(int.parse(rollno), name, email);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  takeAttendance(courseCode,userId,isfaculty!,naam))
                );
              },
              color: AppColor.button,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              child: const Text("Add",style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
