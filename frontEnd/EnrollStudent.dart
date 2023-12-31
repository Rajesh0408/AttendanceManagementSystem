import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../constants/colours.dart';
import 'get/GetCoursesUsingSem.dart';

class EnrollStudent extends StatefulWidget {
  const EnrollStudent({Key? key}) : super(key: key);

  @override
  State<EnrollStudent> createState() => _EnrollStudentState();
}

class _EnrollStudentState extends State<EnrollStudent> {
  String? chooseSem;
  String? chooseCourse;
  List? course;
  List sem=['1','2','3','4','5','6','7','8','9','10'];
  List? studentDetails;
  List? rollNo;
  late List<bool> checkBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rollNo=[];
    //fetchData();

  }

  // Future fetchData() async {
  //   http.Response response;
  //   try {
  //     response = await http.get(Uri.parse('http://10.0.2.2:5000//$sem'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         studentDetails = json.decode(response.body);
  //         checkBox = List.generate(studentDetails!.length, (index) => true);
  //        });
  //     }
  //   } catch (error) {
  //     print("Error: $error");
  //   }
  // }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: const Text('Enroll Student'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0,bottom: 10,left: 35.0,right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.button),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: DropdownButton(
                      hint: Text('  Select semester'),
                      value: chooseSem,
                      onChanged: (newValue) async {
                        setState(() {
                          chooseSem=newValue!.toString();
                        });
                        await updateCourses();
                      }, items:sem.map((valueItem){
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
                padding: const EdgeInsets.only(top: 15.0,bottom: 10,left: 20.0,right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.button),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: DropdownButton(
                    hint: Text('  Select Course'),
                    value: chooseCourse,
                    onChanged: (newValue){
                      setState(() {
                        chooseCourse=newValue!.toString();
                      });
                    }, items:course?.map((valueItem){
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
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: _createDataTable(),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 100.0,right: 100.0,),
            child: MaterialButton(
                color: AppColor.button,
                onPressed: (){

            },
                child: Text('Enroll')),
          )
        ],
      ) ,
    );
  }
  DataTable _createDataTable(){
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns(){
    return [
      DataColumn(label: Text('RollNumber')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('To enroll'))
    ];
  }
  List<DataRow> _createRows(){
    if (studentDetails == null || studentDetails!.isEmpty) {
      return [];
    }
    rollNo?.clear();
    return List.generate(studentDetails!.length, (index){

      if(checkBox![index]){
          rollNo?.add(studentDetails![index]['id'].toString());
        }


      return DataRow(cells: [
        DataCell(Text(studentDetails![index]['id'].toString())),
        DataCell(Text(studentDetails![index]['name'].toString())),
        DataCell(Checkbox(
          activeColor: AppColor.button,
          value: checkBox[index],
          onChanged: (value){
            setState(() {
              checkBox[index]=value!;
            });
          },
        ))
    ]
      );
    }).toList();
  }

  Future<void> updateCourses() async {
    List? result = await fetchCoursesUsingSem(chooseSem!);
    setState(() {
        course=result;
    });
    print("course");
    print(course);

  }

}
