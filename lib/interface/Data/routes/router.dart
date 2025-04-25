// TODO Implement this library.
import 'package:dubaiprojectxyvin/interface/screens/payment/payment_success.dart';
import 'package:dubaiprojectxyvin/interface/screens/edit_profile/Edit_Profile_Page.dart';
import 'package:flutter/material.dart';

import '../../screens/payment/payment_1_screen.dart';
import '../../screens/payment/payment_2_screen.dart';
import '../../screens/edit_profile/profile_details_screen.dart';
import '../../screens/sent_request/sent_request_approved_screen.dart';
import '../../screens/sent_request/sent_request_failed_screen.dart';
import '../../screens/sent_request/sent_request_screen.dart';
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
       case 'Payment2Screen':
      return MaterialPageRoute(builder: (context) => Payment2Screen());
       case 'PaymentSuccess':
      return MaterialPageRoute(builder: (context) => PaymentSuccess());
       case 'EditProfilePage':
      return MaterialPageRoute(builder: (context) => EditProfilePage());
       case 'ProfilePreviewPage':
      return MaterialPageRoute(builder: (context) => ProfilePreviewPage ());
       case 'SentRequestFailedScreen':
      return MaterialPageRoute(builder: (context) => SentRequestFailedScreen());
       case 'SentRequestApprovedScreen':
      return MaterialPageRoute(builder: (context) => SentRequestApprovedScreen());

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
