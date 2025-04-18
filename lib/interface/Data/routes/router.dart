// TODO Implement this library.
import 'package:flutter/material.dart';

import '../../screens/payment_1_screen.dart';
import '../../screens/sent_request_screen.dart';
import '../../screens/splash_screen.dart';
import '../../screens/verify_otp_screen.dart';
import '../../screens/verify_phone.dart';
import '../../screens/welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings? settings) {
  switch (settings?.name) {
    case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
       case 'WelcomeScreen':
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
       case 'VerifyPhone':
      return MaterialPageRoute(builder: (context) => VerifyPhone());
       case 'VerifyOtpScreen':
      return MaterialPageRoute(builder: (context) => VerifyOtpScreen());
       case 'SentRequestScreen':
      return MaterialPageRoute(builder: (context) => SentRequestScreen());
       case 'Payment1Screen':
      return MaterialPageRoute(builder: (context) => Payment1Screen());
       case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
       case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
       case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
       case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
       case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
      

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings?.name}'),
          ),
        ),
      );
  }
}
