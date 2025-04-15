import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300),
            SizedBox(
                height: 200, width: 200, child: Image.asset('assets/png/Logo.png')),
            const SizedBox(height: 166),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset('assets/png/Illustration.png')
            ),
          ],
        ),
      ),
    );
  }
}
