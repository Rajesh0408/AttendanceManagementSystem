import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/constants/colours.dart';
import 'package:myapp/frontEnd/addStudent.dart';
import 'package:myapp/frontEnd/checkAttendance.dart';
import 'NavBar.dart';
import 'OverallAttendance.dart';

class takeAttendance extends StatefulWidget{
  String courseCode;
  String userId;
  bool isfaculty;
  takeAttendance(this.courseCode,this.userId, this.isfaculty);
    @override
    tAttendance createState() => tAttendance();
}

class tAttendance extends State<takeAttendance> {
  String courseCode='';
  String userId='';
  bool? isfaculty;
List<dynamic>? studentDetails;
int _selectedIndex = 0;
DateTime selectedDate = DateTime.now();
int _counterValue=0;
late List<bool> switchStates;
String Date="";
List<Map<String, dynamic>> selectedStudents = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseCode= widget.courseCode;
    userId=widget.userId;
    isfaculty=widget.isfaculty;
    switchStates=[];
    selectedDate = DateTime.now();
    Date= "${selectedDate.toLocal()}".split(' ')[0];
    fetchData();
  }


  Future fetchData() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('http://10.0.2.2:5000/takeAttendance/$courseCode'));
      //response = await http.get(Uri.parse('http://10.0.2.2:5000/addStudent'));
    if (response.statusCode == 200) {
      setState(() {
         studentDetails = json.decode(response.body);
         switchStates = List.generate(studentDetails!.length, (index) => true);
      });
    }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Date="${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomInset: false,
       appBar: AppBar(
         backgroundColor: AppColor.appbar,
         title: Text(courseCode),
       ),
       drawer: NavBar(userId,isfaculty!),
       body: ListView(
          //mainAxisSize: MainAxisSize.max,
           children: <Widget>[
            const Padding(padding: EdgeInsets.only(left: 10.0,top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children:[
                 IconButton(
                   icon: const Icon(Icons.date_range_rounded,size: 35,color: AppColor.button,),
                   onPressed: () {
                     _selectDate(context);
                   },
                 ),
                 Text("\n${Date}"),
                 const Padding(padding: EdgeInsets.only(left: 30.0,top: 20.0,right: 20.0)),
                 const Text("\nHours:\t\t"),
                 CounterButton(
                   loading: false,
                   removeIcon:const Icon(Icons.remove),
                   onChange: (int val) {
                     setState(() {
                       if(val<0){
                         _counterValue = 0;
                       }
                       else if(val>4){
                         _counterValue=4;
                       }
                       else{
                         _counterValue=val;
                       }
                     });
                   },
                   count: _counterValue,
                   countColor: Colors.green,
                   buttonColor: Colors.blueGrey,
                   progressColor: Colors.lightGreenAccent,
                 ),
              ]
            ),
            SizedBox(
              width: double.infinity,
              child: _createDataTable(),
            ),

             Center(
               child: ElevatedButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(
                     builder: (context) => checkAttendance(selectedStudents,courseCode,userId,isfaculty!),
                   ));
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColor.button, // Set the background color of the button, // Set the text color
                 ),
                  child: const Text("CHECK ABSENTEES"),

               ),
             ),
          ],
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
       floatingActionButton: FloatingActionButton.extended(
         backgroundColor: AppColor.button,
         onPressed: () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => addStudent(isfaculty!)),
           );
         },
         icon: Icon(Icons.add,),
         label: const Text('Add Student'),
       ),
       bottomNavigationBar: BottomNavigationBar(
           iconSize: 30.0,
           currentIndex: 0,
           onTap: (int index) {
             setState(() {
               _selectedIndex = index;
             });
             if (index == 1) {
               Navigator.push(context, MaterialPageRoute(
                   builder: (context) =>  OverallAttendance(courseCode,userId,isfaculty!)));
             }
           },
           items: const [
         BottomNavigationBarItem(
           icon: ImageIcon(
             AssetImage(
               'lib/assets/user.png',
             ),
             color: AppColor.button,
             size: 30.0, // Set the size as per your requirement
           ),
           label:'Take Attendance',
         ),
         BottomNavigationBarItem(
           icon: ImageIcon(
             AssetImage(
               'lib/assets/overall.png',
             ),
             size: 30.0, // Set the size as per your requirement
           ),
           label: 'Overall Attendance',
         ),
       ]),
       );
  }
  DataTable _createDataTable(){
  return DataTable(columns: _createColumns(), rows: _createRows());
}
List<DataColumn> _createColumns() {
  return [
    DataColumn(label: Text('RollNumber')),
    DataColumn(label: Text('Name')),
    DataColumn(label: Text("    A / P"))
  ];
}
List<DataRow> _createRows() {
  if (studentDetails == null || studentDetails!.isEmpty) {
    return [];
  }
  return List.generate(studentDetails!.length, (index) {
    final student = studentDetails![index];
    selectedStudents.clear();
    for(int i=0; i <studentDetails!.length; i++) {
      if (switchStates[i]) {
        selectedStudents.add({
          'course_code': courseCode,
          'class_date': Date,
          'class_hour': _counterValue,
          'user_id': studentDetails![i]['id'],
          'user_name': studentDetails![i]['name'],
          'status': true,
        });
      }
      else {
        selectedStudents.add({
          'course_code': courseCode,
          'class_date': Date,
          'class_hour': _counterValue,
          'user_id': studentDetails![i]['id'],
          'user_name': studentDetails![i]['name'],
          'status': false,
        });
      }
    }
    return DataRow(cells: [
        DataCell(Text(student!['id'].toString())),
        DataCell(Text(student!['name'].toString())),
        DataCell(Switch(
          activeColor: AppColor.button,
          value: switchStates[index],
          onChanged: (value) {
            setState(() {
              switchStates[index] = value;
            });
          },
        ),
        ),
      ]
      );
  }).toList();
}
}