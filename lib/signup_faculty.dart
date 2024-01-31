import 'package:flutter/material.dart';
import 'package:myapp/post/postSignUpData.dart';
import 'constants/colours.dart';
import 'logIn_faculty.dart';
import 'logIn_student.dart';
import 'main.dart';

class SignupFaculty extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupFaculty> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isUsernameValid = true;
  bool _isUserIdValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  List roleList = ["Faculty", "Faculty & Advisor", "Student"];
  List years = [
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028'
  ];
  List branchList = ['CS', 'IT'];
  Widget? _additionalWidgets;
  String? branch;
  String? role;
  String? batch;
  String userId = '';
  String username = '';
  String password = '';
  String email = '';
  String confirmPassword = '';
  String regunameerrorTextval = '';

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Attendance Manager'),
        backgroundColor: AppColor.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(1.0)),
              const Center(
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Create an Account\n\n",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: DropdownButton(
                    hint: const Text('  Role'),
                    isExpanded: true,
                    value: role,
                    onChanged: (newValue) {
                      _additionalWidgets = null;
                      setState(() {
                        role = newValue!.toString();
                        print(role == "Faculty & Advisor");
                      });
                    },
                    items: roleList.map((valueItems) {
                      return DropdownMenuItem(
                          value: valueItems,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(valueItems),
                          ));
                    }).toList(),
                  )),
              if (role == "Faculty & Advisor")
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.blue),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('  Advisor for which batch'),
                          value: batch,
                          onChanged: (valueItem) {
                            setState(() {
                              batch = valueItem!.toString();
                              print(batch);
                            });
                          },
                          items: years.map((valueItem) {
                            return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(valueItem),
                                ));
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.blue),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('  Advisor for CS or IT'),
                          value: branch,
                          onChanged: (newValue1) {
                            setState(() {
                              branch = newValue1!.toString();
                              print(branch);
                            });
                          },
                          items: branchList.map((valueItem1) {
                            return DropdownMenuItem<String>(
                                value: valueItem1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(valueItem1),
                                ));
                          }).toList(),
                        ),
                      ),

                    ],
                  ),
                )),

              const SizedBox(
                height: 15.0,
              ),

              _additionalWidgets ?? Container(),
              _buildTextField(
                controller: _usernameController,
                labelText: 'Username',
                isValid: _isUsernameValid,
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = _isValidUsername(value);
                  });
                },
              ),
              _buildTextField(
                controller: _userIdController,
                labelText: 'User ID',
                isValid: _isUserIdValid,
                keyboardType: TextInputType.number,
                //maxLength: 10,
                onChanged: (value) {
                  setState(() {
                    _isUserIdValid = _isValidUserId(value);
                  });
                },
              ),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                isValid: _isEmailValid,
                onChanged: (value) {
                  setState(() {
                    _isEmailValid = _isValidEmail(value);
                  });
                },
              ),
              _buildPasswordTextField(
                controller: _passwordController,
                labelText: 'Password',
                isValid: _isPasswordValid,
                isVisible: _isPasswordVisible,
                onChanged: (value) {
                  setState(() {
                    // if (value.length <= 8) {
                    _isPasswordValid = _isValidPassword(value);
                    // } else {
                    //   _passwordController.text = value.substring(0, 8);
                    //   _passwordController.selection = TextSelection.fromPosition(
                    //       TextPosition(offset: _passwordController.text.length));
                    // }
                  });
                },
                onToggleVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              // Display password requirement message
              if (!_isPasswordValid)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Password should start with an uppercase letter and include alphabets, numerics, and special characters.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              _buildPasswordTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                isValid: _isConfirmPasswordValid,
                isVisible: _isConfirmPasswordVisible,
                onChanged: (value) {
                  setState(() {
                    _isConfirmPasswordValid = _isValidConfirmPassword(value);
                  });
                },
                onToggleVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      if (_checkIfFieldsEmpty()) {
                        _showErrorSnackbar(context,
                            'Signup unsuccessful! All fields are required.');
                      } else {
                        userId = _userIdController.text;
                        username = _usernameController.text;
                        password = _passwordController.text;
                        email = _emailController.text;
                        confirmPassword = _confirmPasswordController.text;
                        bool signUpResult = await postSignUpData(
                            role?? "",batch??"", branch??"", userId, username, password, email);
                        if (signUpResult) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPageFaculty()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("SignUp successful"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("SignUp Unsuccessful"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    color: AppColor.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    child: TextButton(
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPageFaculty()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool isValid = true,
    TextInputType? keyboardType,
    int? maxLength,
    void Function(String value)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: isValid ? null : 'Invalid $labelText',
          errorStyle: const TextStyle(color: Colors.red),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: keyboardType,
        maxLength: maxLength,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String labelText,
    bool isValid = true,
    bool isVisible = false,
    void Function(String value)? onChanged,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: isValid ? null : 'Invalid $labelText.',
          errorStyle: const TextStyle(color: Colors.red),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: onToggleVisibility,
          ),
        ),
        obscureText: !isVisible,
        onChanged: onChanged,
      ),
    );
  }

  bool _isValidUsername(String value) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(value);
  }

  bool _isValidUserId(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[a-zA-Z0-9!@#$.%^&*()_+]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
        .hasMatch(value);
  }

  bool _isValidPassword(String value) {
    if (value.length < 8) {
      return false;
    }

    if (value.isNotEmpty &&
        !RegExp(r'^[A-Z]').hasMatch(value.substring(0, 1))) {
      return false;
    }

    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
        .hasMatch(value)) {
      return false;
    }

    return true;
  }

  bool _isValidConfirmPassword(String value) {
    return value == _passwordController.text;
  }

  bool _checkIfFieldsEmpty() {
    return _usernameController.text.isEmpty ||
        _userIdController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        role == null ||
        role!.isEmpty;
  }

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully signed up!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
