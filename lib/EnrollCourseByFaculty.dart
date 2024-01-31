import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:myapp/listClass.dart';
import 'package:myapp/post/postCourseDetails.dart';
import 'package:myapp/post/postCoursesEnrolledByFaculty.dart';
import 'constants/colours.dart';

import 'get/GetCoursesUsingSem.dart';

class enrollCourseByFaculty extends StatefulWidget{
  String userId;
  bool isfaculty;
  String? name;
  enrollCourseByFaculty(this.userId,this.isfaculty,this.name);
  @override
  addCourseInputState createState() => addCourseInputState();
}

class addCourseInputState extends State<enrollCourseByFaculty> {
  String? chooseSem;
  String? chooseCourse;
  bool? isfaculty;
  List course=[];
  List sem=['1','2','3','4','5','6','7','8','9','10'];
  String userId='';
  String? name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty=widget.isfaculty;
    name=widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Text('Enroll Course'), ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 40.0,),
              Container(
              decoration: BoxDecoration(
              border: Border.all(color: AppColor.blue),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Text('  Select semester'),
                    value: chooseSem,
                    onChanged: (newValue) async {
                      setState(() {
                        chooseSem=newValue!.toString();
                      });
                      await updateCourses();
                    }, items:sem.map((valueItem){
                    return DropdownMenuItem<String>(
                        value: valueItem,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(valueItem),
                        ));
                  }).toList(),
                  ),
                ),
              SizedBox(height: 40.0,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blue),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Text('  Select Course'),
                    value: chooseCourse,
                    onChanged: (newValue){
                      setState(() {
                        chooseCourse=newValue!.toString();
                      });
                    }, items:course.map((valueItem){
                    return DropdownMenuItem<String>(
                        value: valueItem,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(valueItem),
                        ));
                  }).toList(),
                  ),
                ),
              SizedBox(height: 30),

              SizedBox(height: 30),
              MaterialButton(
                minWidth: double.infinity,
                height:60,
                onPressed: () async {
                  print(chooseCourse);
                  if((chooseSem==null) || (chooseCourse==null)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill the above details"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }else{
                    print("userId:"+userId);
                    bool result=await postCoursesEnrolledByFaculty(userId,chooseCourse!);
                    if(result){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => listClass(userId, isfaculty!,name),));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("New course was added successfully"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  listClass(userId,isfaculty!,name)),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid details. Course code already added"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }


                  }},
                color: AppColor.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                ),
                child: const Text("Enroll",style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> updateCourses() async {
    List Newcourses=(await fetchCoursesUsingSem(chooseSem!))!;
    setState(() {
      course= Newcourses;
    });
  }
}