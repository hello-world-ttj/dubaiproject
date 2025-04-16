import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:flutter/material.dart';

import '../compon/GradientButton.dart';
import '../compon/custom_back_bar.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              CustomBackButton(),
              SizedBox(
                height: 200,
              ),
              Center(child: Image.asset('assets/png/otpimage.png')),
              SizedBox(
                height: 30,
              ),
              Text(
                'Verify Otp',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  height: 1.0,
                  letterSpacing: -1,
                  color: Color(0xFF27409A),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Enter the OTP send to +91 **********',
                style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.0,
                    letterSpacing: 0.01 * 16,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                }),
              ),
                      SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'A 4 digit verification code will be sent',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: -0.01 * 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                      Text(
                'Resend OTP',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.0, 
                  letterSpacing: -0.01 * 14, 
                  color: Colors.red
                ),
                textAlign: TextAlign.left,
              ),
                ],
              ),
                 SizedBox(
                height: 30,
              ),
              GradientButton(
                title: 'Confirm',
                onPressed: () {
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
