import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants/colours.dart';
import 'package:myapp/listClass.dart';
import 'package:myapp/post/postCourseDetails.dart';

import 'AdvisorMainPage.dart';

class addCourseInput extends StatefulWidget{
  String userId;
  bool isfaculty;
  addCourseInput(this.userId, this.isfaculty);
  @override
  addCourseInputState createState() => addCourseInputState();
}

class addCourseInputState extends State<addCourseInput> {
  TextEditingController _courseCodeController = TextEditingController();
  TextEditingController _courseNameController = TextEditingController();
  bool? isfaculty;
  String courseCode ='';
  String courseName = '';
  List courseTypeList=['Theory','Lab','Theory come lab'];
  List credits=['2','3','4','5'];
  List semesterList=['1','2','3','4','5','6','7','8','9','10'];
  String? courseType;
  String? totalCredits;
  String? semester;
  String userId='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty=widget.isfaculty!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColor.violet,
        title: Text('Add Course'), ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                TextField(
                  controller: _courseCodeController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    labelText:  'Enter the Course Code',
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
                  controller: _courseNameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    labelText:  'Enter the Course Name',
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                child: DropdownButton(
                  isExpanded: true,
                    hint: Text('  Select course type'),
                    value:courseType,
                    onChanged: (newValue){
                        setState(() {
                          courseType=newValue!.toString();
                        });
                    },
                    items: courseTypeList.map((ValueItem){
                      return DropdownMenuItem<String>(
                          value:ValueItem,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(ValueItem!),
                          ));
                    }).toList(),
                )),
                SizedBox(height: 30),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('  Select Credits'),
                      value:totalCredits,
                      onChanged: (newValue){
                        setState(() {
                          totalCredits=newValue!.toString();
                        });
                      },
                      items: credits.map((ValueItem){
                        return DropdownMenuItem<String>(
                            value:ValueItem,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ValueItem!),
                            ));
                      }).toList(),
                    )),
                SizedBox(height: 30),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('  Select semester'),
                      value:semester,
                      onChanged: (newValue){
                        setState(() {
                          semester=newValue!.toString();
                        });
                      },
                      items: semesterList.map((ValueItem){
                        return DropdownMenuItem<String>(
                            value:ValueItem,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ValueItem!),
                            ));
                      }).toList(),
                    )),

                SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  height:60,
                  onPressed: () async {
                    courseCode = _courseCodeController.text;
                    courseName = _courseNameController.text;
                    print(courseCode);
                    print(courseName);
                    print(courseType);
                    print(totalCredits);
                    print(semester);
                    if(courseCode.isEmpty || courseName.isEmpty || courseType!.isEmpty || totalCredits!.isEmpty || semester!.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill the above details"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }else{
                      bool result=await postCourseDetails(userId,courseCode ,courseName,courseType!,int.parse(totalCredits!),int.parse(semester!));
                      if(result){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("New course was added successfully"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AdvisorMainPage(userId,isfaculty!)),
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
                  color: AppColor.violet,
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
        ),
    );
  }
}