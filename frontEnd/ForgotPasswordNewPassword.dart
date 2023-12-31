import 'package:flutter/material.dart';

import '../constants/colours.dart';

class ForgotPasswordNewPassword extends StatefulWidget {
  const ForgotPasswordNewPassword({super.key});

  @override
  State<ForgotPasswordNewPassword> createState() =>
      _ForgotPasswordNewPasswordState();
}

class _ForgotPasswordNewPasswordState extends State<ForgotPasswordNewPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String newPassword='';
  String confirmPassword='';
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        backgroundColor: AppColor.appbar,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 150.0, left: 30.0, right: 30.0),
                child: Center(
                  child: TextFormField(
                    controller: newPasswordController,
                    onChanged: (value) {
                      newPassword = value.toString();
                    },
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.green)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.green)),
                      hintText: 'Enter the new password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
                child: Center(
                  child: TextFormField(
                    controller: confirmPasswordController,
                    onChanged: (String value) {
                      setState(() {
                        confirmPassword = value.toString();
                      });
                    },
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.green)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.green)),
                      hintText: 'Confirm new password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible = !isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: MaterialButton(
                  onPressed: () {
                    if ((newPassword.isNotEmpty) || (confirmPassword.isNotEmpty)) {
                        if(newPassword != confirmPassword){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("The new password and confirm password doesn't match"),
                            duration: Duration(seconds: 2),
                          ));
                        }
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please fill the above details"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                    if (true) {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordOtp(userId??""),));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please enter the userId'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  height: 45.0,
                  color: AppColor.button,
                  child: const Text(
                    'Reset password',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
