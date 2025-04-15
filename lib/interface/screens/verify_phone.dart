import 'package:flutter/material.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Center(child: Image.asset('assets/png/veryfyphone.png')),
            SizedBox(height: 10,),
            Text(
          'Verify Phone Number',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
            fontSize: 25,
            height: 1.0, // line-height: 100%
            letterSpacing: -1,
            color: Color(0xFF27409A),
          ),
        )
        
          ],
        ),
      ),
    );
  }
}
