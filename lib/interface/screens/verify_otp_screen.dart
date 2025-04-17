import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:dubaiprojectxyvin/interface/compon/common_divider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../compon/GradientButton.dart';
import '../compon/custom_back_bar.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});
 final TextEditingController _otpController = TextEditingController();
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
               PinCodeTextField(
                  appContext: context,
                  length: 6, // Number of OTP digits
                  obscureText: false,
                  keyboardType: TextInputType.number, // Number-only keyboard
                  animationType: AnimationType.fade,
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 4.0,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 55,
                    fieldWidth: 50, selectedColor: CommonColor.lightBlueBackground,
                    activeColor: const Color.fromARGB(255, 232, 226, 226),
                    inactiveColor: Color(0xFFF6F8FF),
                    activeFillColor:  Color(0xFFF6F8FF), // Box color when focused
                    selectedFillColor:  Color(0xFFF6F8FF), // Box color when selected
                    inactiveFillColor:
                         Color(0xFFF6F8FF), // Box fill color when not selected
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _otpController,
                  onChanged: (value) {
                    // Handle input change
                  },
                ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GradientButton(
                title: 'Confirm',
                onPressed: () {},
              ),
              SizedBox(height: 50,),
              Center(
                child: CommonDivider()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
