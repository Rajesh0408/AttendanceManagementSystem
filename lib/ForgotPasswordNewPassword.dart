import 'package:flutter/material.dart';
import 'package:myapp/put/putForgotPassword.dart';


import 'logIn_faculty.dart';
import 'constants/colours.dart';
import 'main.dart';

class ForgotPasswordNewPassword extends StatefulWidget {
  String userId;
  ForgotPasswordNewPassword(this.userId,{super.key});

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
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId= widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        backgroundColor: AppColor.blue,
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
                          borderSide: BorderSide(color: Colors.blue)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue)),
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
                          borderSide: BorderSide(color: AppColor.blue)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: AppColor.blue)),
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
                  onPressed: () async {
                    if ((newPassword.isNotEmpty) || (confirmPassword.isNotEmpty)) {
                        if(newPassword != confirmPassword){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("The new password and confirm password doesn't match"),
                            duration: Duration(seconds: 2),
                          ));
                        }else{
                          if (await putForgotPassword(userId?? "",newPassword)) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageFaculty(),));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Password updated successfully'),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Password doesn't updated"),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please fill the above details"),
                        duration: Duration(seconds: 2),
                      ));
                    }

                  },
                  height: 45.0,
                  color: AppColor.blue,
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
