import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/takeAttendance.dart';
import 'NavBar.dart';
import 'constants/colours.dart';

class OverallAttendance extends StatefulWidget{
  String userId;
  String courseCode;
  bool isfaculty;
  OverallAttendance(this.courseCode,this.userId,this.isfaculty, {super.key});

  @override
  OverallAttendanceState createState() => OverallAttendanceState();
}

class OverallAttendanceState extends State<OverallAttendance> {
  int _selectedIndex=1;
  String courseCode='';
  String userId='';
  bool? isfaculty;
  List<dynamic>? studentDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty=widget.isfaculty!;
    courseCode=widget.courseCode;
    fetchData();
  }

  Future fetchData() async {
    http.Response response;
    try {
      //response = await http.post(Uri.parse('http://10.0.2.2:5000/takeAttendance'));
      response = await http.get(Uri.parse('http://10.0.2.2:5000/OverallAttendanceforCourse/$courseCode'));
      if (response.statusCode == 200) {
        setState(() {
          studentDetails = json.decode(response.body);
          print(studentDetails);
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
        backgroundColor: AppColor.turquoise,
        title: Text('Overall Attendance'),
    ),
    //drawer: NavBar(userId,isfaculty!),
    body:  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: _createDataTable(),
    ),
      // bottomNavigationBar: BottomNavigationBar(
      //     iconSize: 30.0,
      //     currentIndex: _selectedIndex,
      //     onTap: (int index) {
      //       setState(() {
      //         _selectedIndex = index;
      //       });
      //       if (index == 0) {
      //         Navigator.pop(context, MaterialPageRoute(
      //             builder: (context) => takeAttendance(courseCode,userId, isfaculty!)));
      //       }
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: ImageIcon(
      //           AssetImage(
      //             'lib/assets/user.png',
      //           ),
      //           size: 30.0, // Set the size as per your requirement
      //           //color: Colors.black, // Set the color as per your requirement
      //         ),
      //         label: 'Take Attendance',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: ImageIcon(
      //           AssetImage(
      //             'lib/assets/overall.png',
      //           ),
      //           color: AppColor.button,
      //           size: 30.0, // Set the size as per your requirement
      //           //color: Colors.black, // Set the color as per your requirement
      //         ),
      //         label: 'Overall Attendance',
      //       ),
      //     ]),
    );
  }
  DataTable _createDataTable(){
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('RollNumber',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
      DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
      DataColumn(label: Text("Present/Total",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
      DataColumn(label: Text("%GE",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),))

    ];
  }
  List<DataRow> _createRows() {
    if (studentDetails == null || studentDetails!.isEmpty) {
      return [];
    }
    return List.generate(studentDetails!.length, (index) {
      return DataRow(cells: [
        DataCell(Text(studentDetails![index]['user_id'].toString())),
        DataCell(Text(studentDetails![index]['user_name'].toString())),
        DataCell(Center(child: Text(studentDetails![index]['present_hours'].toString() +" / "+
            studentDetails![index]['total_class_hours'].toString()))),
        DataCell(Text(studentDetails![index]['percentage'].toString()))
      ]
      );
    }).toList();
  }
}