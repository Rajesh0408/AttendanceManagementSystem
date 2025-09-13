import 'dart:convert';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/HomePageStudent.dart';

import 'constants/colours.dart';

class absentIntimationStudent extends StatefulWidget{
  String userId;
  bool isfaculty;
  String name;
  absentIntimationStudent(this.userId, this.isfaculty , this.name, {super.key});

  @override
  absentIntimationStudentState createState() => absentIntimationStudentState();
}

class absentIntimationStudentState extends State<absentIntimationStudent> {
  @override

  String userId='';
  bool? isfaculty;
  String? name;
  final int _selectedIndex = 1;

  TextEditingController hourController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String hour ='';
  String? courseCode;
  String reason ='';
  String Date='';
  DateTime selectedDate = DateTime.now();
  String date='';
  int _counterValue=0;
  //List<Map<String, dynamic>>? courseCodeList;
  late List courseCodeList;

  Future fetchData() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('https://attendancemanagementsystembackend.onrender.com/ViewStudentEnrolled/$userId'));
      if (response.statusCode == 200) {
        setState(() {
          courseCodeList = json.decode(response.body);
          print(courseCodeList);
        });
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty = widget.isfaculty;
    name = widget.name;
    courseCodeList=[];
    fetchData();
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
        print(Date);
        date=Date;
      });
    }
  }

   Future<bool> postData() async {
    http.Response response;
    String? code= courseCode?.split(" ")[0];
      Map<String,dynamic> absentIntimationDetails={
        'user_id':userId,
        'course_code': code,
        'absent_date': date,
        'absent_hour': _counterValue,
        'absent_reason': reason
      };
      String jsonData = json.encode(absentIntimationDetails);
      print("jsonData $jsonData");
      response = await http.post(
          Uri.parse('https://attendancemanagementsystembackend.onrender.com/TakeForm'),
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
        backgroundColor: AppColor.blue,
        title: const Text('Absent Intimation Form'),
      ),
      //drawer: NavBarStudent(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                icon: const Icon(Icons.date_range_rounded,size: 35,color: AppColor.blue,),
                onPressed: () {
                  _selectDate(context);
                },
              ),
                Text("\n Date: $date"),
                 const Text("\t\t\t\t\t\t\t\t\t\t\t\t\t\t"),
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
              countColor: AppColor.blue,
              buttonColor: Colors.blueGrey,
              progressColor: Colors.lightGreenAccent,
            ),],),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.blue),
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: const Text('  Choose the course code'),
                value: courseCode,
                onChanged: (newValue1) {
                  setState(() {
                    courseCode = newValue1!.toString();
                    print('coursecode: $courseCode');
                  });
                },
                items: courseCodeList.map((valueItem1) {
                  return DropdownMenuItem<String>(
                      value: valueItem1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(valueItem1),
                      ));
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            const SizedBox(height: 30),
            MaterialButton(
              minWidth: double.infinity,
              height:60,
              onPressed: () async {
                reason = reasonController.text;
                print(reason);
                if((date=="") || (_counterValue==0) || courseCode==null || reason=="" ){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill the above details correctly"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }else {
                  if (await postData()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sent successfully"),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageStudent(userId, isfaculty, name)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Already the absence form for this date and course is intimated!!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              color: AppColor.blue,
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

    );
  }
}