import 'package:dubaiprojectxyvin/Data/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/GradientButton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(gradient: CommonColor.scaffoldGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/png/Line.png'),
                      const SizedBox(width: 10),
                      const Text(
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
                      const SizedBox(width: 10),
                      Image.asset('assets/png/Line.png'),
                    ],
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/png/Logo.png'),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        GradientButton(
                          title: 'Request to join',
                          onPressed: () {},
                          gradientBorderColors: const [
                            Color(0xFF092073),
                            Color(0xFF1835A0),
                          ],
                          labelColor: Colors.black,
                          labelFontSize: 14,
                          borderWidth: 1.5,
                        ),
                        const SizedBox(height: 10),
                        GradientButton(
                          title: 'Login',
                          onPressed: () {
                            Navigator.of(context).pushNamed('VerifyPhone');
                          },
                          gradientColors: const [
                            Color(0xFF0F38C2),
                            Color(0xFF072182),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset('assets/png/Illustration.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
