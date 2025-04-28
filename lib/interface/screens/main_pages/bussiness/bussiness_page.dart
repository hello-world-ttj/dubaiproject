import 'package:flutter/material.dart';

class BussinessPage extends StatelessWidget {
  const BussinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 420,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFC6D2FF), // your given color
              width: 2, // thickness of the border
            ),
            borderRadius: BorderRadius.circular(
                12), // optional if you want rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32.7,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Kappa',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            height: 1.0, // 100% line height
                            letterSpacing: -0.36, // -3% of 12px = -0.36
                            color: Color(0xFF000000), // black
                          ),
                        ),
                        Text(
                          'Company name',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.0, // 100% line height
                            letterSpacing: -0.36, // -3% of 12px = -0.36
                            color: Color(0x99242424), // 60% opacity black
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 188,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset('assets/png/image.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Quis enim nisl ullamcorper tristique integer orci nunc in eget. Amet hac bibendum dignissim eget pretium turpis in non cum.',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.3, // 130% line height
                    letterSpacing: -0.14, // -1% of 14px = -0.14
                    color: Color(0xFF000000), // pure black
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '02 Jan 2023',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        letterSpacing: 0.0,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '|',
                    ),
                      SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.timer),
                      SizedBox(
                      width: 5,
                    ),
                     Text(
                      '09:00 pm',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
