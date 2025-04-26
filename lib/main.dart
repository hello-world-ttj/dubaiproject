import 'package:dubaiprojectxyvin/interface/Data/routes/router.dart'as router;
import 'package:dubaiprojectxyvin/interface/Data/routes/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
    initialRoute: 'MainPage',
  
    );
  }
}
