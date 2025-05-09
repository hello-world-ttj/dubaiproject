import 'package:dubaiprojectxyvin/interface/components/common_color.dart';
import 'package:flutter/material.dart';

import '../../components/GradientButton.dart';
import '../../components/common_divider.dart';

class SentReq2Screen extends StatelessWidget {
  const SentReq2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8EBFF),
              Colors.white,
            ],
            stops: [0.3, 0.7],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 250,),
            Image.asset('assets/png/approved.png'),
            SizedBox(height: 30),
            Text(
              'Your request has been approved!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                height: 1.0, // 100% line-height
                letterSpacing: -0.01, // -1%
                color: Color(0xFF016A03), // Green color code
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to Dubai Connect — dive in and discover a world of business opportunities.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.0,
                  letterSpacing: -0.01,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            GradientButton(
              title: 'Explore',
              onPressed: () {
                 Navigator.of(context).pushNamed('Payment1Screen');
              },
            ),
            CommonDivider()
          ],
        ),
      ),
    );
  }
}
