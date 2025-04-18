import 'package:flutter/material.dart';

class Payment1Screen extends StatelessWidget {
  const Payment1Screen({super.key});

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Get Dubai Connect Premium\nfor Your Business',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 28,
                height: 1.0,
                letterSpacing: -0.01,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    CircularIconWithLine(),
                    CircularIconWithLine(),
                    CircularIconWithOutLine()
                  ],),
                   Text(
          'Unlock Business Features',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1.0,
            letterSpacing: -0.16,
            color: const Color(0xFF0B0B0B),
          ),
          textAlign: TextAlign.center,
        ),
                
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class CircularIconWithLine extends StatelessWidget {
  const CircularIconWithLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular container with icon
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEFF), // Light blue background
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFB8C9FF), // Blue border
                width: 2,
              ),
            ),
            child: Image.asset('assets/png/shutter_speed.png')),

        // Vertical line below the circle
        Container(
          width: 2,
          height: 50,
          color: const Color(0xFF1B2C5F), // Same dark blue
        ),
      ],
    );
  }
}

class CircularIconWithOutLine extends StatelessWidget {
  const CircularIconWithOutLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular container with icon
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEFF), // Light blue background
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFB8C9FF), // Blue border
                width: 2,
              ),
            ),
            child: Image.asset('assets/png/shutter_speed.png')),
      ],
    );
  }
}
