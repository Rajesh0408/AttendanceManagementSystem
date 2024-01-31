import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:myapp/post/postEnrollStudent.dart';
import 'constants/colours.dart';

import 'get/GetCoursesUsingSem.dart';

class EnrollStudent extends StatefulWidget {
  String? userId;
  EnrollStudent(this.userId, {Key? key}) : super(key: key);

  @override
  State<EnrollStudent> createState() => _EnrollStudentState();
}

class _EnrollStudentState extends State<EnrollStudent> {
  String? userId;
  String? chooseSem;
  String? chooseCourse;
  List? course;
  List sem = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List? studentDetails;
  late List<Map<String, dynamic>> list;
  late List<bool> checkBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = [];
    userId = widget.userId;
    print("usrid in enrollstudent" + userId!);
    fetchData();
  }

  Future fetchData() async {
    http.Response response;
    try {
      response = await http
          .get(Uri.parse('http://10.0.2.2:5000/MyStudentList/$userId'));
      if (response.statusCode == 200) {
        setState(() {
          studentDetails = json.decode(response.body);
          print(studentDetails);
          checkBox = List.generate(studentDetails!.length, (index) => true);
        });
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.violet,
        title: const Text('Enroll Student'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 10, left: 10.0, right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.violet),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: DropdownButton(
                hint: Text('  Select semester'),
                value: chooseSem,
                onChanged: (newValue) async {
                  setState(() {
                    chooseSem = newValue!.toString();
                  });
                  await updateCourses();
                },
                items: sem.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(valueItem),
                      ));
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 10, left: 10.0, right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.violet),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: DropdownButton(
                hint: Text('  Select Course'),
                value: chooseCourse,
                onChanged: (newValue) {
                  setState(() {
                    chooseCourse = newValue!.toString();
                  });
                },
                items: course?.map((valueItem) {
                  return DropdownMenuItem<String>(
                      value: valueItem,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(valueItem),
                      ));
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: _createDataTable(),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 100.0,
              right: 100.0,
            ),
            child: MaterialButton(
                color: AppColor.violet,
                onPressed: () async {
                  print(list);
                  if (chooseCourse != null) {
                    bool result = await postEnrollStudent(list);
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Enrolled successfully"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid details. Already Enrolled"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                        content: Text("Please select the semester and course code"),
                  duration: Duration(seconds: 2),
                        ),
                    );
                  }
                },
                child: Text('Enroll'),
                height: 50,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('RollNumber',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
      DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
      DataColumn(label: Text('To enroll',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),))
    ];
  }

  List<DataRow> _createRows() {
    if (studentDetails == null || studentDetails!.isEmpty) {
      return [];
    }
    list.clear();
    return List.generate(studentDetails!.length, (index) {
      if (checkBox[index]) {
        list.add({
          "course_code": chooseCourse,
          "user_id": studentDetails![index]['user_id'].toString()
        });
      }

      return DataRow(cells: [
        DataCell(Text(studentDetails![index]['user_id'].toString())),
        DataCell(Text(studentDetails![index]['user_name'].toString())),
        DataCell(Checkbox(
          activeColor: AppColor.violet,
          value: checkBox[index],
          onChanged: (value) {
            setState(() {
              checkBox[index] = value!;
            });
          },
        ))
      ]);
    }).toList();
  }

  Future<void> updateCourses() async {
    List? result = await fetchCoursesUsingSem(chooseSem!);
    setState(() {
      course = result;
    });
  }
}
