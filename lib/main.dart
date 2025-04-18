import 'package:dubaiprojectxyvin/interface/screens/payment_1_screen.dart';
import 'package:dubaiprojectxyvin/interface/screens/sent_req_1_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/sent_req_2_screen.dart';
import 'package:dubaiprojectxyvin/interface/screens/sent_request_screen.dart';
import 'package:dubaiprojectxyvin/interface/screens/splash_screen.dart';
import 'package:dubaiprojectxyvin/interface/screens/verify_otp_screen.dart';
import 'package:dubaiprojectxyvin/interface/screens/verify_phone.dart';
import 'package:dubaiprojectxyvin/interface/screens/welcome_screen.dart';
import 'package:dubaiprojectxyvin/interface/Data/routes/router.dart'as router;
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
    initialRoute: 'Payment1Screen',
  
    );
  }
}
