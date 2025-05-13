import 'package:dubaiprojectxyvin/Data/common_style.dart';
import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStatusCheck extends ConsumerStatefulWidget {
  const UserStatusCheck({super.key});

  @override
  ConsumerState<UserStatusCheck> createState() => _UserStatusCheckState();
}

class _UserStatusCheckState extends ConsumerState<UserStatusCheck> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    final userState = ref.read(userProvider);
    
    userState.whenData((user) {
      if (user.status == null) {
        Navigator.pushReplacementNamed(context, 'CreateAccountScreen');
        return;
      }

      switch (user.status?.toLowerCase()) {
        case 'active':
          if (user.name == null || user.name!.isEmpty) {
            Navigator.pushReplacementNamed(context, 'CreateAccountScreen');
          } else {
            Navigator.pushReplacementNamed(context, 'MainPage');
          }
          break;
        
        case 'inactive':
          _showStatusMessage(
            'Account Inactive',
            'Your account is currently inactive. Please contact support for assistance.',
            'Contact Support'
          );
          break;
        
        case 'suspended':
          _showStatusMessage(
            'Account Suspended',
            'Your account has been suspended. Please contact support for more information.',
            'Contact Support'
          );
          break;
        
        case 'deleted':
          _showStatusMessage(
            'Account Deleted',
            'This account has been deleted. Please create a new account if you wish to continue.',
            'Create New Account'
          );
          break;
        
        case 'blocked':
          _showStatusMessage(
            'Account Blocked',
            'Your account has been blocked. Please contact support for assistance.',
            'Contact Support'
          );
          break;
        
        case 'awaiting_payment':
          _showStatusMessage(
            'Payment Required',
            'Please complete your payment to activate your account.',
            'Make Payment',
            onActionPressed: () {
              Navigator.pushNamed(context, 'PaymentScreen');
            }
          );
          break;
        
        case 'trial':
          Navigator.pushReplacementNamed(context, 'MainPage');
          break;
        
        default:
          Navigator.pushReplacementNamed(context, 'CreateAccountScreen');
      }
    });
  }

  void _showStatusMessage(String title, String message, String actionText, {VoidCallback? onActionPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: kHeadTitleSB,
        ),
        content: Text(
          message,
          style: kBodyTitleR,
        ),
        actions: [
          TextButton(
            onPressed: onActionPressed ?? () {
              // Default action to contact support
            },
            child: Text(
              actionText,
              style: kBodyTitleM.copyWith(
                color: const Color(0xFF27409A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF27409A),
            ),
            const SizedBox(height: 20),
            Text(
              'Please wait...',
              style: kBodyTitleR.copyWith(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 