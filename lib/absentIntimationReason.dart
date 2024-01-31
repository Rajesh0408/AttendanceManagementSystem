import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:myapp/post/postAcceptReject.dart';

import 'NavBar.dart';
import 'absentIntimation.dart';
import 'constants/colours.dart';

class absentIntimationReason extends StatefulWidget {
  String userId;
  bool isfaculty;
  final int absent_id;
  final String user_name;
  int status;
  absentIntimationReason(
      this.absent_id, this.user_name, this.userId, this.isfaculty, this.status,
      {super.key});
  @override
  absentIntimationReasonState createState() => absentIntimationReasonState();
}

class absentIntimationReasonState extends State<absentIntimationReason> {
  Map? studentDetails;
  String? userId;
  bool? isfaculty;
  int absent_id = 0;
  String user_name = '';
  int? status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    absent_id = widget.absent_id;
    user_name = widget.user_name;
    userId = widget.userId;
    isfaculty = widget.isfaculty;
    status = widget.status;
    print(status);
    fetchData();
  }

  Future fetchData() async {
    http.Response response;
    try {
      response = await http
          .get(Uri.parse('http://10.0.2.2:5000/ViewFormFaculty/$absent_id'));
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

  void _sendOTPEmail(String email_id) async {
    email_id = email_id;
    String username = 'rajesh.a0408@gmail.com'; // Replace with your email
    String password = 'oknw wawm aqor iqlh'; // Replace with your email password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Rajesh')
      ..recipients.add(email_id)
      ..subject = 'Password Reset OTP'
      ..text = 'Your OTP for password reset is: ';

    try {
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mail sent Successfully'),
        ),
      );
    } catch (e) {
      print('Error sending OTP email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mail doesn\'t sent Successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        title: Text(user_name),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.orange),
              borderRadius: BorderRadius.circular(20),
              color: AppColor.orangeCard),
          //margin: EdgeInsets.all(50.0),
          width: 350.0,
          height: 520.0,
          //color: AppColor.card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tCourse code:   ${studentDetails?['course_code']}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tRoll number:  ${studentDetails?['user_id']}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tDate:   ${studentDetails?['absent_date']}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tNumber of hours: ${studentDetails?['absent_hour']}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.orangeCardd),
                  width: 300.0,
                  height: 220.0,
                  //color: AppColor.button,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\nReason: ",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      Center(
                          child: Text(
                        "\n  ${studentDetails?['absent_reason']}",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!(status == 0 || status == 1))
              ElevatedButton(
                onPressed: () async {
                  status = 0;
                  print(status);
                  await postAcceptReject(absent_id, status!);
                  //_sendOTPEmail(studentDetails?['email_id']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            absentIntimation(userId!, isfaculty!),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, // Set the background color
                ),
                child: Text('Reject'),
              ),
            if (!(status == 0 || status == 1))
              ElevatedButton(
                onPressed: () async {
                  status = 1;
                  await postAcceptReject(absent_id, status!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            absentIntimation(userId!, isfaculty!),
                      ));
                  //_sendOTPEmail(studentDetails?['email_id']);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColor.button, // Set the background color
                ),
                child: Text('Accept'),
              ),
          ],
        ),
      ),
    );
  }
}
