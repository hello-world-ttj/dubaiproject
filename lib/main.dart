import 'package:dubaiprojectxyvin/Data/routes/router.dart' as router;
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/services/snackbar_service.dart';
import 'package:dubaiprojectxyvin/Data/utils/secure_storage.dart';
import 'package:dubaiprojectxyvin/Data/theme/app_theme.dart';
import 'package:dubaiprojectxyvin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await loadSecureData();
  await dotenv.load(fileName: ".env");
    runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
        scaffoldMessengerKey: SnackbarService.scaffoldMessengerKey,
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: 'Splash',
      theme: AppTheme.lightTheme,
    );
  }
}
