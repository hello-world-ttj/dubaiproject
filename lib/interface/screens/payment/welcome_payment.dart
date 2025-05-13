import 'package:dubaiprojectxyvin/interface/components/GradientButton.dart';
import 'package:dubaiprojectxyvin/Data/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/common_divider.dart';
import 'package:flutter/material.dart';

class WelcomePayment extends StatelessWidget {
  const WelcomePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
            ),
            Image.asset('assets/png/Logo.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                height: 1.0, // 100% line-height
                letterSpacing: -0.01, // -1%
                color: Color(0xFF000000), // Black
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'You have successfully became our member. Enjoy your full Experience of Connect Dubai',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 1.0, // 100% line-height
                letterSpacing: -0.01, // -1%
                color: Color(0xFF000000), // Default text color fallback
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GradientButton(
                title: 'Complete Your Profile',
                onPressed: () {
                  Navigator.of(context).pushNamed('EditProfilePage');
                }),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFF1B2C5F)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Skip to Home Page',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B2C5F),
                  ),
                ),
                
              ),
            ),
          CommonDivider()
          ],
        ),
      ),
    );
  }
}
