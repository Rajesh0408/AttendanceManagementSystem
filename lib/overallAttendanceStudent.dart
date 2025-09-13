import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants/colours.dart';

class overallAttendanceStudent extends StatefulWidget{
  String userId;
  overallAttendanceStudent(this.userId, {super.key});

  @override
  OverallAttendanceStudentState createState() => OverallAttendanceStudentState();
}

class OverallAttendanceStudentState extends State<overallAttendanceStudent> {
  final int _selectedIndex=1;
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
      //response = await http.post(Uri.parse('https://attendancemanagementsystembackend.onrender.com/takeAttendance'));
      response = await http.get(Uri.parse('https://attendancemanagementsystembackend.onrender.com/OverallAttendanceforStudent/$userId'));
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
        title: const Text('Overall Attendance'),
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
      const DataColumn(label: Text('Course Code')),
      const DataColumn(label: Text('Course Name')),
      const DataColumn(label: Text("Present/Total")),
      const DataColumn(label: Text("%GE"))
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
        DataCell(Center(child: Text("${studentDetails![index]['present_hours']} / ${studentDetails![index]['total_hours']}"))),
        DataCell(Text(studentDetails![index]['percentage'].toString())),
      ]
      );
    }).toList();
  }
}