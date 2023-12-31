import 'dart:convert';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/frontEnd/NavBarStudent.dart';
import 'package:myapp/frontEnd/takeAttendance.dart';
import '../constants/colours.dart';
import 'NavBar.dart';
import 'overallAttendanceStudent.dart';

class absentIntimationStudent extends StatefulWidget{
  String userId;
  absentIntimationStudent(this.userId);

  @override
  absentIntimationStudentState createState() => absentIntimationStudentState();
}

class absentIntimationStudentState extends State<absentIntimationStudent> {
  @override

  String userId='';
  int _selectedIndex = 1;

  TextEditingController hourController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String hour ='';
  String courseCode ='';
  String reason ='';
  String Date='';
  DateTime selectedDate = DateTime.now();
  String date='';
  int _counterValue=0;

  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
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
        date=Date;
      });
    }
  }

   Future<bool> postData() async {
    http.Response response;
      Map<String,dynamic> absentIntimationDetails={
        'user_id':userId,
        'course_code': courseCode,
        'absent_date': date,
        'absent_hour': _counterValue,
        'absent_reason': reason
      };
      String jsonData = json.encode(absentIntimationDetails);
      print(jsonData);
      response = await http.post(
          Uri.parse('http://10.0.2.2:5000/absence_intimation'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonData,
      );
      if (response.statusCode == 201) {
        print('Data posted successfully');
        print(response.body);
        return true;
      } else {
        print('Failed to post data. Error ${response.statusCode}: ${response.body}');
        return false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: Text('Absent Intimation Form'),
      ),
      drawer: NavBarStudent(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                icon: const Icon(Icons.date_range_rounded,size: 35,color: AppColor.button,),
                onPressed: () {
                  _selectDate(context);
                },
              ),
                Text("\n Date: ${date}"),
                 Text("\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
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
            ),],),
            SizedBox(height: 30),
            TextField(
              controller: courseCodeController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                labelText:  'Enter the course code',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              maxLines: null,
              controller: reasonController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                labelText:  'Enter the Reason',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: double.infinity,
              height:60,
              onPressed: () async {
                Date = dateController.text;
                hour = hourController.text;
                courseCode = courseCodeController.text;
                reason = reasonController.text;
                if(await postData()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Sent successfully"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Already the absence form for this date and course is intimated!!"),
                        duration: Duration(seconds: 2),
                      ),
                  );
                }
              },
              color: AppColor.button,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              child: const Text("Send to Faculty",style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white
              ),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0) {
              Navigator.pop(context, MaterialPageRoute(
                  builder: (context) => overallAttendanceStudent(userId)));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/overall.png',
                ),
                size: 30.0, // Set the size as per your requirement
                 // Set the color as per your requirement
              ),
              label: 'Overall Attendance',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/form.png',
                ),
                color: AppColor.button,
                size: 30.0, // Set the size as per your requirement
                //color: Colors.black, // Set the color as per your requirement
              ),
              label: 'Absent Intimation Form',

            ),
          ]),
    );
  }
}