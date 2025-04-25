import 'package:flutter/material.dart';

import '../../compon/GradientButton.dart';
import '../../compon/common_divider.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 300,),
          Image.asset('assets/png/paymensucess.png'),
          SizedBox(height: 20),
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
         SizedBox(height: 200),
          GradientButton(
            title: 'Continue',
            onPressed: () {
               Navigator.of(context).pushNamed('WelcomePayment');
            },
          ),
          CommonDivider()
        ],
      ),
    ));
  }
}
