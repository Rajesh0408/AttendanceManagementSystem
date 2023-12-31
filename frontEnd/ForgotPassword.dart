import 'package:flutter/material.dart';

import '../constants/colours.dart';
import 'ForgotPasswordOtp.dart';

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
        backgroundColor: AppColor.appbar,
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
                          borderSide: BorderSide(color: Colors.green)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.green)
                        ),
                        hintText: 'Enter your userId'
                      ),


                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: MaterialButton(onPressed: (){
                    if(userId?.isNotEmpty ?? false){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordOtp(userId??""),));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter the userId'),duration: Duration(seconds: 2),));
                    }
                },
                  height: 45.0,
                  color: AppColor.button,
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