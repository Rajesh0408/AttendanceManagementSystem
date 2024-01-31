import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myapp/HomePageFaculty.dart';
import 'package:myapp/takeAttendance.dart';
import 'NavBar.dart';
import 'post/postAttendance.dart';
import 'constants/colours.dart';

class checkAttendance extends StatefulWidget {
  List<Map<String, dynamic>> selectedStudents;
  String courseCode;
  String userId;
  bool isfaculty;
  String? name;
  checkAttendance(
      this.selectedStudents, this.courseCode, this.userId, this.isfaculty, this.name);
  checkAttendanceState createState() => checkAttendanceState();
}

class checkAttendanceState extends State<checkAttendance> {
  String courseCode = '';
  String userId = '';
  bool? isfaculty;
  String? name;
  late List<Map<String, dynamic>> selectedStudents;
  late List<Map<String, dynamic>> data;
  List<Map<String, dynamic>> absenties = [];
  @override
  void initState() {
    super.initState();
    name= widget.name;
    selectedStudents = widget.selectedStudents;
    courseCode = widget.courseCode;
    userId = widget.userId;
    isfaculty = widget.isfaculty;
    Data();
  }

  void Data() {
    setState(() {
      for (int i = 0; i < selectedStudents.length; i++) {
        if (selectedStudents[i]['status'] == false) {
          absenties.add(selectedStudents[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Text('ABSENTEES'),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Container(
            //padding: EdgeInsets.only(left: 10.0),
            width: double.infinity,
            child: DataTable(
              columns: _buildDataColumns(), // Define your columns
              rows: _buildDataRows(), // Define your rows based on the data
            ),
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            takeAttendance(courseCode, userId, isfaculty!,name),
                      ));
                },
                child: Text(" Go Back"),
                height: 50,
                color: AppColor.blue,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 50),
              MaterialButton(
                  onPressed: () {
                    postAttendance(selectedStudents, courseCode);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePageFaculty(userId, isfaculty,name)));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Attendance Saved successfully"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text("Save attendance"),
                height: 50,
                color: AppColor.blue,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              )
            ],
          ))
        ],
      ),
    );
  }

  List<DataColumn> _buildDataColumns() {
    // Customize your columns based on your data structure
    return [
      DataColumn(label: Text('\t\t\t\t\t\t\t\t\t\t\t\t RollNumber')),
      DataColumn(label: Text('Name')),
      // Add more columns as needed
    ];
  }

  List<DataRow> _buildDataRows() {
    // Build rows based on your data
    return absenties.map((item) {
      return DataRow(
        cells: [
          DataCell(Text("\t\t\t\t\t\t\t\t${item['user_id'].toString()}")),
          DataCell(Text(item['user_name'].toString())),
        ],
      );
    }).toList();
  }
}
