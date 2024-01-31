import 'package:flutter/material.dart';
import 'package:myapp/post/postForgotPasswordUserId.dart';


import 'ForgotPasswordOtp.dart';
import 'get/ForgotPasswordUserID.dart';
import 'constants/colours.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController userIdController = TextEditingController();
  String? userId;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userIdController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
        backgroundColor: AppColor.blue,
      ),
      body: ListView(
          children:[ Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300.0,left: 30.0,right: 30.0),
                  child: Center(
                    child: TextFormField(
                      controller: userIdController,
                      onChanged: (value){
                          userId=value.toString();
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        hintText: 'Enter your userId'
                      ),


                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: MaterialButton(onPressed: () async {
                    if(userId?.isNotEmpty ?? false){
                      if(await postForgotPasswordUserId(userId!)){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordOtp(userId??""),));

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter a valid userId'),duration: Duration(seconds: 2),));

                      }
                       }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter the userId'),duration: Duration(seconds: 2),));
                    }
                },
                  height: 45.0,
                  color: AppColor.blue,
                  child: const Text('Reset password',style: TextStyle(fontSize: 20.0),),
                ),
              )

            ],
          ),
    ],
      ),
    );
  }
}