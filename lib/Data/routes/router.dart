// TODO Implement this library.
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/about_us.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/add_product.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/my_businesses.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/my_events.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/my_products.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/my_reviews.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/my_subscription.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/privacy_policy.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/request_nfc.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/terms.dart';
import 'package:dubaiprojectxyvin/interface/screens/navbar.dart';
import 'package:dubaiprojectxyvin/interface/screens/payment/payment_success.dart';
import 'package:dubaiprojectxyvin/interface/screens/edit_profile/Edit_Profile_Page.dart';
import 'package:dubaiprojectxyvin/interface/screens/sent_request/sent_req_2_screen.dart';
import 'package:flutter/material.dart';

import '../../interface/screens/payment/payment_1_screen.dart';
import '../../interface/screens/payment/payment_2_screen.dart';
import '../../interface/screens/edit_profile/profile_details_screen.dart';
import '../../interface/screens/payment/welcome_payment.dart';
import '../../interface/screens/sent_request/sent_request_approved_screen.dart';
import '../../interface/screens/sent_request/sent_request_failed_screen.dart';
import '../../interface/screens/sent_request/sent_request_screen.dart';
import '../../interface/screens/splash_screen.dart';
import '../../interface/screens/verify_otp_screen.dart';
import '../../interface/screens/verify_phone.dart';
import '../../interface/screens/welcome_screen.dart';

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
 case 'SentReq2Screen':
      return MaterialPageRoute(builder: (context) =>  SentReq2Screen());
       case 'WelcomePayment':
      return MaterialPageRoute(builder: (context) =>  WelcomePayment());
  case 'MyEvents':
      return MaterialPageRoute(builder: (context) => MyEventsPage());
    case 'MyProducts':
      return MaterialPageRoute(builder: (context) => MyProductPage());
    case 'EnterProductsPage':
      return MaterialPageRoute(builder: (context) => EnterProductsPage());
    case 'MyBusinesses':
      return MaterialPageRoute(builder: (context) => MyBusinessesPage());
          case 'RequestNFC':
      return MaterialPageRoute(builder: (context) => RequestNFCPage());
        case 'MyReviews':
      return MaterialPageRoute(builder: (context) => MyReviewsPage());
      
    case 'MySubscriptionPage':
      return MaterialPageRoute(builder: (context) => MySubscriptionPage());

    case 'Terms':
      return MaterialPageRoute(builder: (context) => TermsAndConditionsPage());

    case 'PrivacyPolicy':
      return MaterialPageRoute(builder: (context) => PrivacyPolicyPage());

       case 'MainPage':
      return MaterialPageRoute(builder: (context) =>  MainPage());
         case 'AboutPage':
      return MaterialPageRoute(builder: (context) => AboutPage());

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
