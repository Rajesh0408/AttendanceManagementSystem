import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants/colours.dart';
import 'package:myapp/frontEnd/takeAttendance.dart';
import 'NavBar.dart';
import 'post/postAttendance.dart';

class checkAttendance extends StatefulWidget{
  List<Map<String,dynamic>>  selectedStudents;
  String courseCode;
  String userId;
  bool isfaculty;
  checkAttendance(this.selectedStudents,this.courseCode,this.userId, this.isfaculty);
  checkAttendanceState createState() => checkAttendanceState();
}
class checkAttendanceState extends State<checkAttendance>{
  String courseCode='';
  String userId='';
  bool? isfaculty;
  late List<Map<String, dynamic>>  selectedStudents;
  late List<Map<String, dynamic>> data;
  List<Map<String, dynamic>> absenties=[];
  @override
  void initState() {
    super.initState();
    selectedStudents = widget.selectedStudents;
    courseCode = widget.courseCode;
    userId=widget.userId;
    isfaculty=widget.isfaculty;
    Data();
  }
  void Data(){
    setState(() {
      for (int i = 0; i < selectedStudents.length; i++) {
        if(selectedStudents[i]['status']==false){
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
        backgroundColor: AppColor.appbar,
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
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, MaterialPageRoute(
                      builder:  (context) => takeAttendance(courseCode,userId,isfaculty!),
                  ));
              }, style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.button, // Set the background color of the button, // Set the text color
                  ),
                child: Text(" Go Back")),
                SizedBox(width: 50),
              ElevatedButton(onPressed: (){
                postAttendance(selectedStudents,courseCode);
                Navigator.pop(context, MaterialPageRoute(
                    builder: (context) => takeAttendance(courseCode,userId,isfaculty!)));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Attendance Saved successfully"),
                    duration: Duration(seconds: 2),
                  ),
                );

              },
                  style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.button, // Set the background color of the button, // Set the text color
              ),
                  child: Text("Save attendance"))
            ],
          )
            )
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
    return absenties.map((item){
        return DataRow(
          cells: [
            DataCell(Text("\t\t\t\t\t\t\t\t${item['user_id'].toString()}")),
            DataCell(Text(item['user_name'].toString())),
          ],
        );
    }).toList();
  }
}
