import 'dart:math';

import 'package:flutter/material.dart';

import '../../compon/GradientButton.dart';
import '../../compon/common_color.dart';
import '../../compon/common_divider.dart';
import '../../compon/custom_back_bar.dart';

class SentRequestScreen extends StatelessWidget {
  const SentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  CustomBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ), // Positioned left

                  Expanded(
                    // Takes up the remaining space
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/png/Line.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'Create your Account',
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
                  ),
                ],
              ),

              /// 👤 Profile Avatar with exact size and style
              Center(
                child: SizedBox(
                  width: 149,
                  height: 149,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Dashed circular border
                      CustomPaint(
                        size: const Size(149, 149),
                        painter: DottedBorderPainter(width: 2),
                      ),

                      // Inner white circle with avatar/icon
                      Container(
                        width: 125,
                        height: 125,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),

                      // Edit icon
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE8EBFF),
                            border: Border.all(color: const Color(0xFFCBD5FF)),
                          ),
                          child: const Icon(Icons.edit,
                              size: 20, color: Color(0xFF1A2F71)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Name',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0.16,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter your phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Mobile Number',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0.16,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "6282569856",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email ID',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0.16,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter your email id",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Designation',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0.16,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter your Designation",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Company',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0.16,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Select",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GradientButton(
                title: 'Sent Request',
                onPressed: () {
                  Navigator.of(context).pushNamed('SentReq2Screen');
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: CommonDivider()),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final double width;
  DottedBorderPainter({this.width = 2});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFCBD5FF)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    const int dashCount = 60;
    const double gap = 5;
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    for (int i = 0; i < dashCount; i++) {
      final double angle = (i * 2 * pi) / dashCount;
      final double x1 = center.dx + radius * cos(angle);
      final double y1 = center.dy + radius * sin(angle);
      final double x2 = center.dx + (radius - gap) * cos(angle);
      final double y2 = center.dy + (radius - gap) * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
