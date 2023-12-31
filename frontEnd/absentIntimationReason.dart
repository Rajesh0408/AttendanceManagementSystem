import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:myapp/frontEnd/post/postAcceptReject.dart';
import '../constants/colours.dart';
import 'NavBar.dart';
class absentIntimationReason extends StatefulWidget{
  final int absent_id;
  final String user_name;
  const absentIntimationReason(this.absent_id, this.user_name, {super.key});
  @override
  absentIntimationReasonState createState() => absentIntimationReasonState();
}

class absentIntimationReasonState extends State<absentIntimationReason> {
Map? studentDetails;
int absent_id=0;
String user_name='';
bool status=false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    absent_id=widget.absent_id;
    user_name=widget.user_name;
    fetchData();
  }
  Future fetchData() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('http://10.0.2.2:5000/view_form/$absent_id'));
      if (response.statusCode == 200) {
        setState(() {
          studentDetails = json.decode(response.body);
            });
      }
    } catch (error) {
      print("Error: $error");
    }
  }

void _sendOTPEmail(String email_id) async {
  email_id=email_id;
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
        backgroundColor: AppColor.appbar,
        title: Text(user_name),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.button),
              borderRadius: BorderRadius.circular(20),
              color: AppColor.card),
        //margin: EdgeInsets.all(50.0),
        width: 350.0,
        height: 520.0,
        //color: AppColor.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50.0),
          Text("\t\t\t\t\t\t\t\t\t\tCourse code:   ${studentDetails?['course_code']}", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 30.0),
          Text("\t\t\t\t\t\t\t\t\t\tRoll number:  ${studentDetails?['user_id']}", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 30.0),
          Text("\t\t\t\t\t\t\t\t\t\tDate:   ${studentDetails?['absent_date']}", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 30.0),
          Text("\t\t\t\t\t\t\t\t\t\tNumber of hours: ${studentDetails?['absent_hour']}", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 30.0),
          Center(
            child: Container(

              padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.reason),
            width: 300.0,
            height: 220.0,
            //color: AppColor.button,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("\nReason: ", style: TextStyle(fontSize: 18.0, color: Colors.black),),
                 Center(
                child: Text("\n  ${studentDetails?['absent_reason']}", style: TextStyle(fontSize: 18.0, color: Colors.black),)),
                ],
              ),
             ),
            ),
        ],
      ),),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                  status=false;
                  postAcceptReject(absent_id,status);
                  _sendOTPEmail(studentDetails?['email_id']);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mail sent successfully "),
                      duration: Duration(seconds: 2),
                    ),
                  );

              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // Set the background color
              ),
              child: Text('Reject'),

            ),
            ElevatedButton(
              onPressed: () {
                status=true;
                postAcceptReject(absent_id,status);
                _sendOTPEmail(studentDetails?['email_id']);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Mail sent successfully "),
                    duration: Duration(seconds: 2),
                  ),
                );

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
