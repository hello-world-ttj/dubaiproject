import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:dubaiprojectxyvin/interface/compon/custom_back_bar.dart';
import 'package:flutter/material.dart';

import '../compon/GradientButton.dart';
import '../compon/common_divider.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

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
              CustomBackButton(onTap: () { Navigator.pop(context); },),
              SizedBox(
                height: 200,
              ),
              Center(child: Image.asset('assets/png/veryfyphone.png')),
              SizedBox(
                height: 30,
              ),
              Text(
                'Verify Phone Number',
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
                'Phone Number',
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
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter your phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
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
              SizedBox(
                height: 30,
              ),
              GradientButton(
                title: 'Generate OTP',
                onPressed: () {
                     Navigator.of(context).pushNamed('VerifyOtpScreen');
                },
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
