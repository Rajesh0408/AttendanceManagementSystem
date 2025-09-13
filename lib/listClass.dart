import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/takeAttendance.dart';
import 'constants/colours.dart';
import 'EnrollCourseByFaculty.dart';
import 'package:http/http.dart' as http;

class listClass extends StatefulWidget{
  //final String userId;

  // Constructor with userId as an optional parameter with a default value
  //listClass({this.userId, Key? key}) : super(key: key);
   String userId;
   bool isfaculty;
   String? name;
   listClass(this.userId, this.isfaculty, this.name, {super.key});
  //listClass({Key? key, this.userId=''}) : super(key: key);

  @override
  Myapp createState() => Myapp();
}

class Myapp extends State<listClass> {
  List<dynamic>? listData;
  int id = 0;
  String userId='';
  bool? isfaculty;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty=widget.isfaculty;
    name=widget.name;
    fetchData();
    print("userID in listclass:$userId");
  }

  Future fetchData() async {
      http.Response response;
      response =
      await http.get(Uri.parse('http://10.10.51.107:5000/DailyAttendanceStudent/$userId'));
      if (response.statusCode == 200) {
        setState(() {
          listData = json.decode(response.body);
        });
      }
  }

  Color card = const Color(0xffc4f8c8);
  Color appbar = const Color.fromARGB(255, 33, 159, 42);

  //var currentPage = DrawerSections.settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: const Text('Attendance Manager'),
      ),
      //drawer: NavBar(userId,isfaculty!),
      body: GridView.builder(itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisSpacing: 0, crossAxisSpacing: 0),
          children: [
              GestureDetector(
              onTap: () {
                String courseCode= listData![index]['course_code'];
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => takeAttendance(courseCode,userId,isfaculty!,name)),
                );
              },
            child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: AppColor.listClass),
              child: Center(
                child: listData==null? const Center(child: Text('Enroll courses')): Text("${listData![index]['course_code']}\n${listData![index]['course_name'].toString()}",
                        style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,),
              ),
            ),
            ),

          ],
        ),
      );
    },
        itemCount: listData == null? 0: listData?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 0, crossAxisSpacing: 10),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:AppColor.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => enrollCourseByFaculty(userId,isfaculty!,name)),
          );
        },
        icon: const Icon(Icons.add,),
        label: const Text("Enroll course"),
        tooltip: 'Add course',
      ),
    );
  }
}
