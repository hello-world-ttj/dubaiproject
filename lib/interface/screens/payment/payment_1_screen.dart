import 'package:flutter/material.dart';

import '../../compon/GradientButton.dart';
import '../../compon/common_divider.dart';

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
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
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: const [
                        CircularIconWithLine(),
                        CircularIconWithLine(),
                        CircularIconWithOutLine(),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          FeatureText(),
                          FeatureText(),
                          FeatureText(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GradientButton(
                  title: 'View Plan',
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
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
                    child: const Text('Skip Now',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B2C5F))),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose the right subscription to boost your business visibility and network.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: CommonDivider()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureText extends StatelessWidget {
  const FeatureText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Unlock Business Features',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.0,
              letterSpacing: -0.01,
              color: Color(0xFF0B0B0B),
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Gain access to exclusive business tools, premium listings, event invites, and verified badge for credibility.',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularIconWithLine extends StatelessWidget {
  const CircularIconWithLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEFF),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFB8C9FF),
              width: 2,
            ),
          ),
          child: Image.asset(
            'assets/png/shutter_speed.png',
            width: 24,
            height: 24,
          ),
        ),
        Container(
          width: 2,
          height: 40,
          color: const Color(0xFF1B2C5F),
        ),
      ],
    );
  }
}

class CircularIconWithOutLine extends StatelessWidget {
  const CircularIconWithOutLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEFF),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFB8C9FF),
          width: 2,
        ),
      ),
      child: Image.asset(
        'assets/png/shutter_speed.png',
        width: 24,
        height: 24,
      ),
    );
  }
}
