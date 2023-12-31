import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/frontEnd/takeAttendance.dart';
import '../constants/colours.dart';
import 'NavBar.dart';
import 'NavBarStudent.dart';
import 'absentIntimationStudent.dart';

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
      response = await http.get(Uri.parse('http://10.0.2.2:5000/overallAttendanceforStudent/$userId'));
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
        backgroundColor: AppColor.appbar,
        title: Text('Overall Attendance'),
      ),
      drawer: NavBarStudent(),
      body :  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _createDataTable(),
    ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 1) {
               Navigator.push(context, MaterialPageRoute(
                   builder: (context) => absentIntimationStudent(userId)));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/overall.png',
                ),
                size: 30.0, // Set the size as per your requirement
                color: AppColor.button, // Set the color as per your requirement
              ),
              label: 'Overall Attendance',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/form.png',
                ),
                //color: AppColor.button,
                size: 30.0, // Set the size as per your requirement
                //color: Colors.black, // Set the color as per your requirement
              ),
              label: 'Absent Intimation Form',

            ),
          ]),
    );
  }
  DataTable _createDataTable(){
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Course Code')),
      DataColumn(label: Text('Course Name')),
      DataColumn(label: Text("Present Hours"))
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
        DataCell(Center(child: Text(studentDetails![index]['total_hours'].toString()
            +" / "+ studentDetails![index]['total_class_hours'].toString()))),
      ]
      );
    }).toList();
  }
}