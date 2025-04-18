import 'package:flutter/material.dart';

import '../../interface/screens/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings? settings) {
  switch (settings?.name) {  case 'Splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());
     
      
      
       default: return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings?.name}'),
          ),
        ),
      );

}}
