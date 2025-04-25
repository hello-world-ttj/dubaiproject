import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/png/Line.png'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'WELCOME TO',
                  style: TextStyle(
                    color: CommonColor.greyText,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.0,
                    letterSpacing: 0.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/png/Line.png'),
              ],
            ),
            const SizedBox(height: 100),
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/png/Logo.png')),
            SizedBox(
              height: 60,
              width: 380,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.teal, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  'Request to join',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 380,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F38C2),
                    Color(0xFF072182),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                  onPressed: () {
                  Navigator.of(context).pushReplacementNamed('VerifyPhone');

                  },
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0.0,
                        textBaseline: TextBaseline.alphabetic,
                        color: CommonColor.white),
                  )),
            ),
            const SizedBox(height: 120),
            SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset('assets/png/Illustration.png')),
          ],
        ),
      ),
    );
  }
}
