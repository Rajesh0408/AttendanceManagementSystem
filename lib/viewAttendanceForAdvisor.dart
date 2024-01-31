import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/takeAttendance.dart';
import 'NavBar.dart';
import 'constants/colours.dart';

class ViewAttendanceForAdvisor extends StatefulWidget {
  String userId;

  ViewAttendanceForAdvisor(
    this.userId,
  );

  @override
  ViewAttendanceForAdvisorState createState() =>
      ViewAttendanceForAdvisorState();
}

class ViewAttendanceForAdvisorState extends State<ViewAttendanceForAdvisor> {
  String userId = '';
  List<dynamic>? studentDetails;
  List courseList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = widget.userId;
    fetchData();
  }

  Future fetchData() async {
    http.Response response;
    try {
      response = await http.get(
          Uri.parse('http://10.0.2.2:5000/OverallAttendanceforAdvisor/102114'));
      if (response.statusCode == 200) {
        setState(() {
          studentDetails = json.decode(response.body);
          print(studentDetails);
          courseList.clear();
          for (int i = 0; i < studentDetails![0]['attendance'].length; i++) {
            var course_name =
                studentDetails![0]['attendance'][i]['course_name'];
            courseList.add(course_name);
          }
          print(courseList);
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
        title: Text('Overall Attendance'),
      ),
      //drawer: NavBar(userId,isfaculty!),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _createDataTable(),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    if (courseList.isEmpty) {
      return [const DataColumn(label: Text('No Courses'))];
    }
    List<DataColumn> columns = [
      const DataColumn(
        label: Text('Roll Number',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
      ),
    ];

    // Adding DataColumn for each course in courseList
    columns.addAll(courseList.map((courseName) {
      return DataColumn(
        label: Text(courseName,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
      );
    }).toList());

    return columns;
  }

  List<DataRow> _createRows() {
    if (studentDetails == null || studentDetails!.isEmpty) {
      return [];
    }

    return List.generate(studentDetails!.length, (index) {
      var attendanceData = studentDetails![index]['attendance'];

      List<DataCell> dataCells = [
        DataCell(Text(studentDetails![index]['student'].toString())),
      ];

      dataCells.addAll(
        attendanceData.map<DataCell>((attendance) {
          return DataCell(
            Text(attendance['percentage'].toString() + "%"),
          );
        }).toList(),
      );

      return DataRow(cells: dataCells);
    }).toList();
  }

}
