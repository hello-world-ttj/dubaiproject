import 'package:dubaiprojectxyvin/Data/common_color.dart';
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/utils/secure_storage.dart';
import 'package:dubaiprojectxyvin/interface/screens/menu_pages/terms.dart';
import 'package:flutter/material.dart';

class EulaAgreementScreen extends StatelessWidget {
  const EulaAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = NavigationService();
    return Scaffold(
      backgroundColor: CommonColor.white,
      body: Column(
        children: [
          Expanded(
            child: TermsAndConditionsPage(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await SecureStorage.write('eula_agreed', 'true');

                      navigationService
                          .pushNamedReplacement('ProfileCompletion');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonColor.backgroundColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'I Agree to Terms & Conditions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      SecureStorage.deleteAll();
                      navigationService.pushNamedReplacement('PhoneNumber');
                    },
                    child: const Text(
                      'Decline',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
