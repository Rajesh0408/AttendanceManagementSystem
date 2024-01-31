import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/takeAttendance.dart';
import 'NavBar.dart';
import 'NavBarStudent.dart';
import 'absentIntimationStudent.dart';
import 'constants/colours.dart';

class overallAttendanceStudent extends StatefulWidget{
  String userId;
  overallAttendanceStudent(this.userId);

  @override
  OverallAttendanceStudentState createState() => OverallAttendanceStudentState();
}

class OverallAttendanceStudentState extends State<overallAttendanceStudent> {
  int _selectedIndex=1;
  String userId='';
  List<dynamic>? studentDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    fetchData();
  }

  Future fetchData() async {
    http.Response response;
    try {
      //response = await http.post(Uri.parse('http://10.0.2.2:5000/takeAttendance'));
      response = await http.get(Uri.parse('http://10.0.2.2:5000/OverallAttendanceforStudent/$userId'));
      if (response.statusCode == 200) {
        setState(() {
          studentDetails = json.decode(response.body);
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
        backgroundColor: AppColor.orange,
        title: Text('Overall Attendance'),
      ),
      //drawer: NavBarStudent(),
      body :  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _createDataTable(),
    ),
    );
  }
  DataTable _createDataTable(){
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Course Code')),
      DataColumn(label: Text('Course Name')),
      DataColumn(label: Text("Present/Total")),
      DataColumn(label: Text("%GE"))
    ];
  }
  List<DataRow> _createRows() {
    if (studentDetails == null || studentDetails!.isEmpty) {
      return [];
    }
    return List.generate(studentDetails!.length, (index) {
      return DataRow(cells: [
        DataCell(Text(studentDetails![index]['course_code'].toString())),
        DataCell(Text(studentDetails![index]['course_name'].toString())),
        DataCell(Center(child: Text(studentDetails![index]['present_hours'].toString()
            +" / "+ studentDetails![index]['total_hours'].toString()))),
        DataCell(Text(studentDetails![index]['percentage'].toString())),
      ]
      );
    }).toList();
  }
}