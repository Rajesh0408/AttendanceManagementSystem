import 'package:flutter/material.dart';
import 'package:myapp/signup_faculty.dart';
import 'constants/colours.dart';
import 'package:myapp/post/postLoginDetails.dart';
import 'ForgotPassword.dart';
import 'HomePageFaculty.dart';
import 'HomePageStudent.dart';
import 'NavBar.dart';
import 'listClass.dart';
import 'overallAttendanceStudent.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPageFaculty(),
  ));
}
class LoginPageFaculty extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageFaculty> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorText = '';
  bool isPasswordVisible = false;
  String userId = '';
  String password = '';
  Map<String,dynamic>? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Attendance Manager'),
        backgroundColor: AppColor.blue,
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
                      result=await postLogInData(userId, password);
                      if (result!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("LogIn Unsuccessful. Invalid userid or password"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );
                        //NavBar(userId,password);
                      }
                      else{
                        print("Login_faculty:"+result?['user_name']);
                        if(result?['role']=="faculty&advisor"){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomePageFaculty(userId,false,result?['user_name'])));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("LogIn successful"),
                              duration: Duration(seconds: 2),
                              backgroundColor: AppColor.appbar,
                            ),
                          );
                        }else if(result?['role']=="student"){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomePageStudent(userId,false,result?['user_name'])));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("LogIn successful"),
                              duration: Duration(seconds: 2),
                              backgroundColor: AppColor.appbar,
                            ),
                          );
                        }else{
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomePageFaculty(userId,true,result?['user_name'])));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("LogIn successful"),
                              duration: Duration(seconds: 2),
                              backgroundColor: AppColor.appbar,
                            ),
                          );
                        }

                      }
                    }
                },
                color: AppColor.blue, // Changed to green
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
            SizedBox(height: 3),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.only(left: 185.0),
                child: const Text("Forgot password?",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()),
                );
              },
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
                        MaterialPageRoute(builder: (context) => SignupFaculty()),
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
                errorText.startsWith('Invalid') ? Colors.red : AppColor.blue,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                errorText.startsWith('Invalid') ? Colors.red : AppColor.blue,
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
    maxLength,
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
             // maxLength: maxLength,
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
                        : AppColor.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorText.startsWith('Invalid')
                        ? Colors.red
                        : AppColor.blue,
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

    if ( !RegExp(r'^[0-9]+$').hasMatch(userId)) {
      setState(() {
        errorText = 'Invalid UserID or password. Reenter!';
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
        errorText = 'Invalid UserID or Password. Reenter!';
      });
      return false;
    }
  }

  bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])')
        .hasMatch(password);
  }

  void validatePassword(String value) {
    if(value.length<8){
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])')
        .hasMatch(value)) {
      setState(() {
        errorText ='';
        //'Password should start with an uppercase letter, contain numerics, alphabets, special characters and length should be atleast 8. Reenter!';
      });
    }}else {
      setState(() {
        errorText = '';
      });
    }
  }
}