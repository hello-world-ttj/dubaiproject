import 'package:flutter/material.dart';

import '../compon/GradientButton.dart';
import '../compon/common_divider.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

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
      child: Center(
        child: Column(
          children: [
            Text(
              'Skip Now',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                height: 1.0, // 100% line-height
                letterSpacing: -0.16, // -1% of 16px = -0.16
              ),
            ),

            Image.asset('assets/png/paymensucess.png'),
              const SizedBox(height: 20),
            Text(
  'Payment Success',
  style: TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.0, // 100% line-height = fontSize * 1.0
    letterSpacing: -0.18, // -1% of 18px = -0.18
  ),
),

            const SizedBox(height: 20),
            GradientButton(
              title: 'View Your Plan Details',
              onPressed: () {},
            ),
          CommonDivider()
          ],
        ),
      ),
    ));
  }
}
