import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/post/postForgotPasswordOTP.dart';
import 'constants/colours.dart';

import 'ForgotPasswordNewPassword.dart';

class ForgotPasswordOtp extends StatefulWidget {
  String userId;

  ForgotPasswordOtp(this.userId, {super.key});

  @override
  State<ForgotPasswordOtp> createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId= widget.userId;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (var controller in otpControllers){
      controller.dispose();
    }
  }

  String getOtp(){
    return otpControllers.map((controller) => controller.text).join();
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
          Padding(
          padding: const EdgeInsets.only(top: 250.0,left: 20.0,right: 20.0),
          child: Column(
              children: [
                const Text('We have sent the OTP to your email id. Please enter it correctly.'),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) =>
                      SizedBox(
                      height: 50,
                      width: 50,
                      child: TextFormField(
                        controller: otpControllers[index],
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          if(value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(color: Colors.blue)
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)
                          )
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),

                ),

          ),
                const SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: MaterialButton(onPressed: () async {
                      String otp=getOtp();
                      if(await postForgotPasswordOTP(otp,userId?? "")){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordNewPassword(userId?? ""),));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter the correct OTP'),duration: Duration(seconds: 2),backgroundColor: Colors.red,));
                      }

                  },
                    height: 45.0,
                    color: AppColor.blue,
                    child: const Text('Verify otp',style: TextStyle(fontSize: 20.0),),
                  ),
                )
          ],
        ),
    ),
    ],
      ),
    );
  }
}
