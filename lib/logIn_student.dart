import 'package:flutter/material.dart';
import 'package:myapp/post/postLoginDetails.dart';
import 'package:myapp/post/postStudentLogIn.dart';
import 'package:myapp/signup_student.dart';
import 'NavBar.dart';
import 'listClass.dart';
import 'constants/colours.dart';
import 'overallAttendanceStudent.dart';


class LoginPageStudent extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageStudent> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorText = '';
  bool isPasswordVisible = false;
  String userId = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Attendance Manager'),
        backgroundColor: AppColor.appbar,
      ),
      body: SingleChildScrollView(child:Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text ("LogIn", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 20,),
                Text("Welcome back ! Login with your credentials",style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),),
                SizedBox(height: 30,)
              ],
            ),
            SizedBox(height: 20),
            makeInput(
              label: "User ID",
              controller: userIdController,
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
            makePasswordInput(
              label: "Password",
              controller: passwordController,
              isPasswordVisible: isPasswordVisible,
              togglePasswordVisibility: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  if(validateCredentials()) {
                    userId = userIdController.text;
                    password = passwordController.text;
                    if (await postStudentLogInData(userId, password)) {
                      //NavBar(userId,password);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => overallAttendanceStudent(userId)));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("LogIn successful"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("LogIn Unsuccessful"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },


                color: AppColor.button, // Changed to green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Don't have an account?"),
                GestureDetector(
                  child: TextButton(
                    child: const Text("SignUp",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupStudent()),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      ),
    );
  }

  Widget makeInput(
      {label, obscureText = false, controller, keyboardType, maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:
            errorText.startsWith('Invalid') ? Colors.red : Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          style: TextStyle(
            color:
            errorText.startsWith('Invalid') ? Colors.red : Colors.black87,
          ),
          onChanged: (value) {
            if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
              setState(() {
                errorText = 'Invalid User ID. Reenter!';
              });
            } else {
              setState(() {
                errorText = '';
              });
            }
          },
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                errorText.startsWith('Invalid') ? Colors.red : Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                errorText.startsWith('Invalid') ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget makePasswordInput({
    label,
    controller,
    isPasswordVisible,
    togglePasswordVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:
            errorText.startsWith('Invalid') ? Colors.red : Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              obscureText: !isPasswordVisible,
              onChanged: (value) {
                validatePassword(value);
              },
              decoration: InputDecoration(
                counterText: '',
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorText.startsWith('Invalid')
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorText.startsWith('Invalid')
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  bool validateCredentials() {
    String userId = userIdController.text;
    String password = passwordController.text;

    if (userId.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(userId)) {
      setState(() {
        errorText = 'Invalid User ID. Reenter!';
      });
      return false;
    }

    if (isPasswordValid(password)) {
      setState(() {
        errorText = '';
      });
      return true;
    } else {
      setState(() {
        errorText = 'Invalid Password. Reenter!';
      });
      return false;
    }
  }

  bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])')
        .hasMatch(password);
  }

  void validatePassword(String value) {
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])')
        .hasMatch(value)) {
      setState(() {
        errorText =
        'Password should start with an uppercase letter, contain numerics, alphabets, and special characters. Reenter!';
      });
    } else {
      setState(() {
        errorText = '';
      });
    }
  }
}