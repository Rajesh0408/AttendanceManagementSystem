import 'package:flutter/material.dart';
import 'package:myapp/post/postStudentSignUp.dart';
import 'logIn_student.dart';
import 'constants/colours.dart';

class SignupStudent extends StatefulWidget {
  const SignupStudent({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupStudent> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isUsernameValid = true;
  bool _isUserIdValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String userId='';
  String username='';
  String password='';
  String email='';
  String confirmPassword='';
  String regunameerrorTextval='';

  final String _errorMessage = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset :false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Attendance Manager'),
        backgroundColor: AppColor.appbar,
      ),
      body: SingleChildScrollView(child:Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(15.0)),
            const Center(child: Text ("SignUp", style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),),
            Center(child: Text("Create an Account\n\n",style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),),),
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
              maxLength: 10,
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
                  if (value.length <= 8) {
                    _isPasswordValid = _isValidPassword(value);
                  } else {
                    _passwordController.text = value.substring(0,8);
                    _passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _passwordController.text.length));
                  }
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
                padding: const EdgeInsets.only(top: 3,left: 3),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height:60,
                  onPressed:() async{
                    if (_checkIfFieldsEmpty()) {
                      _showErrorSnackbar(context,
                          'Signup unsuccessfully! All fields are required.');
                    } else {
                      userId = _userIdController.text;
                      username = _usernameController.text;
                      password = _passwordController.text;
                      email = _emailController.text;
                      confirmPassword = _confirmPasswordController.text;
                      bool signUpResult = await postStudentSignUpData(
                          userId, username, password, email);
                      if (signUpResult) {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginPageStudent()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("SignUp successful"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Student details already exists "),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  color: AppColor.button,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: const Text("SignUp",style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 16,

                  ),),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                GestureDetector(
                  child: TextButton(
                    child: const Text("Login",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColor.button
                    ),),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPageStudent()),
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
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
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
          errorText: isValid ? null : 'Invalid $labelText. Requirements...',
          errorStyle: const TextStyle(color: Colors.red),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
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
    if (value.length > 8) {
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
        _confirmPasswordController.text.isEmpty;
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