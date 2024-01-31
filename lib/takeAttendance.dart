import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/addStudent.dart';
import 'package:myapp/checkAttendance.dart';
import 'NavBar.dart';
import 'constants/colours.dart';
import 'OverallAttendance.dart';

class takeAttendance extends StatefulWidget{
  String courseCode;
  String userId;
  bool isfaculty;
  String? name;
  takeAttendance(this.courseCode,this.userId, this.isfaculty, this.name);
    @override
    tAttendance createState() => tAttendance();
}

class tAttendance extends State<takeAttendance> {
  String courseCode='';
  String userId='';
  bool? isfaculty;
  String? name;
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
    name=widget.name;
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
      response = await http.get(Uri.parse('http://10.0.2.2:5000/TakeAttendance/$courseCode'));
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
         backgroundColor: AppColor.blue,
         title: Text(courseCode),
       ),
       //drawer: NavBar(userId,isfaculty!),
       body: ListView(
          //mainAxisSize: MainAxisSize.max,
           children: <Widget>[
            const Padding(padding: EdgeInsets.only(left: 10.0,top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children:[
                 IconButton(
                   icon: const Icon(Icons.date_range_rounded,size: 35,color: AppColor.blue,),
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
                   countColor: Colors.blue,
                   buttonColor: Colors.blue,
                   progressColor: Colors.blue,
                 ),
              ]
            ),
            SizedBox(
              width: double.infinity,
              child: _createDataTable(),
            ),

             Center(
               child: MaterialButton(
                 onPressed: (){
                   if(_counterValue==0){
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text("Please select the hours"),
                         duration: Duration(seconds: 2),
                       ),
                     );
                   }else{
                     Navigator.push(context, MaterialPageRoute(
                       builder: (context) => checkAttendance(selectedStudents,courseCode,userId,isfaculty!,name),
                     ));
                 }
                 },

                  child: const Text("CHECK ABSENTEES"),
                 height: 50,
                 color: AppColor.blue,
                 shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

               ),
             ),
          ],
       ),
       // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
       // floatingActionButton: FloatingActionButton.extended(
       //   backgroundColor: AppColor.blue,
       //   onPressed: () {
       //     Navigator.push(
       //       context,
       //       MaterialPageRoute(builder: (context) => addStudent(isfaculty!)),
       //     );
       //   },
       //   icon: Icon(Icons.add,),
       //   label: const Text('Add Student'),
       // ),

       );
  }
  DataTable _createDataTable(){
  return DataTable(columns: _createColumns(), rows: _createRows());
}
List<DataColumn> _createColumns() {
  return [
    const DataColumn(label: Text('RollNumber',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
    const DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
    const DataColumn(label: Text("    A / P",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),))
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
          'user_id': studentDetails![i]['user_id'],
          'user_name': studentDetails![i]['user_name'],
          'status': true,
        });
      }
      else {
        selectedStudents.add({
          'course_code': courseCode,
          'class_date': Date,
          'class_hour': _counterValue,
          'user_id': studentDetails![i]['user_id'],
          'user_name': studentDetails![i]['user_name'],
          'status': false,
        });
      }
    }
    return DataRow(cells: [
        DataCell(Text(student!['user_id'].toString())),
        DataCell(Text(student!['user_name'].toString())),
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