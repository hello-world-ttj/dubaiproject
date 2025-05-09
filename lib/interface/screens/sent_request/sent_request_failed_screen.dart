import 'package:flutter/material.dart';

import '../../components/common_color.dart';

class SentRequestFailedScreen extends StatelessWidget {
  const SentRequestFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/png/sentreq2.png'),
            Text(
              "Your request has been Rejected!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.0, // line-height: 100%
                letterSpacing: -0.18, // -1% of 18px = -0.18
                color: Color(0xFFFF0004), // #FF0004
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Unfortunately, your request to access the app has been declined by the admin. Please contact support or try again later if you believe this is a mistake.",
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.0, // line-height equivalent
                letterSpacing: -1.0, // letter-spacing equivalent
                color: Color(0xFF6C6C6C), // color #6C6C6C
                // textAlign: TextAlign.center, // text-align center
              ),
            )
          ],
        )),
      ),
    );
  }
}
