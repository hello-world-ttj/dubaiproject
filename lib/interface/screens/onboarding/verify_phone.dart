import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_style.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/loading_notifier.dart';
import 'package:dubaiprojectxyvin/Data/services/api_routes/user_api/login/user_login_api.dart';
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/services/snackbar_service.dart';
import 'package:dubaiprojectxyvin/interface/components/buttons/custom_back_button.dart';
import 'package:dubaiprojectxyvin/interface/screens/onboarding/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../components/buttons/GradientButton.dart';

final countryCodeProvider = StateProvider<String?>((ref) => '91');

class VerifyPhone extends ConsumerStatefulWidget {
  const VerifyPhone({super.key});

  @override
  ConsumerState<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends ConsumerState<VerifyPhone> {
  final TextEditingController _mobileController = TextEditingController();
  final NavigationService _navigationService = NavigationService();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);
    return Container(
      decoration: const BoxDecoration(gradient: scaffoldGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svg/icons/verify_phone.svg',
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 15,
                          child: Image.asset(
                            'assets/gif/kite.gif',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Verify Phone Number',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      height: 1.0,
                      letterSpacing: -1,
                      color: Color(0xFF27409A),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.0,
                      letterSpacing: 0.16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  IntlPhoneField(
                    validator: (phone) {
                      if (phone!.number.length > 9) {
                        if (phone.number.length > 10) {
                          return 'Phone number cannot exceed 10 digits';
                        }
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                    ),
                    controller: _mobileController,
                    disableLengthCheck: true,
                    showCountryFlag: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF4F7FF),
                      hintText: 'Enter Your Number',
                      hintStyle: kSmallTitleUL,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE5ECFF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE5ECFF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE5ECFF)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                    ),
                    onCountryChanged: (value) {
                      ref.read(countryCodeProvider.notifier).state =
                          value.dialCode;
                    },
                    initialCountryCode: 'IN',
                    onChanged: (PhoneNumber phone) {
                      print(phone.completeNumber);
                    },
                    dropdownTextStyle: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                    ),
                    flagsButtonPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    showDropdownIcon: true,
                    dropdownIconPosition: IconPosition.trailing,
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'A 6 digit verification code will be sent',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: -0.14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GradientButton(
                    title: 'Generate OTP',
                    isLoading: isLoading,
                    onPressed: () {
                      if (!isLoading) {
                        _handleOtpGeneration(context);
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleOtpGeneration(BuildContext context) async {
    SnackbarService snackbarService = SnackbarService();
    final countryCode = ref.watch(countryCodeProvider);
    FocusScope.of(context).unfocus();
    ref.read(loadingProvider.notifier).startLoading();

    try {
      if (countryCode == '971') {
        if (_mobileController.text.length != 9) {
          snackbarService.showSnackBar('Please Enter valid mobile number');
        } else {
          final data = await submitPhoneNumber(
              countryCode == '971'
                  ? 9710.toString()
                  : countryCode ?? 91.toString(),
              context,
              _mobileController.text);
          final verificationId = data['verificationId'];
          final resendToken = data['resendToken'];
          if (verificationId != null && verificationId.isNotEmpty) {
            log('Otp Sent successfully');

            await _navigationService.pushNamedReplacement(
              'VerifyOtpScreen',
              arguments: {
                'phone': '$countryCode${_mobileController.text}',
                'verificationId': verificationId,
                'resendToken': resendToken ?? '',
              },
            );
          } else {
            snackbarService.showSnackBar('Failed');
          }
        }
      } else if (countryCode != '971') {
        if (_mobileController.text.length != 10) {
          snackbarService.showSnackBar('Please Enter valid mobile number');
        } else {
          final data = await submitPhoneNumber(
              countryCode == '971'
                  ? 9710.toString()
                  : countryCode ?? 971.toString(),
              context,
              _mobileController.text);
          final verificationId = data['verificationId'];
          final resendToken = data['resendToken'];
          if (verificationId != null && verificationId.isNotEmpty) {
            log('Otp Sent successfully');
            ref.read(loadingProvider.notifier).stopLoading();
            await _navigationService.pushNamedReplacement(
              'VerifyOtpScreen',
              arguments: {
                'phone': _mobileController.text,
                'verificationId': verificationId,
                'resendToken': resendToken ?? '',
              },
            );
          } else {
            snackbarService.showSnackBar('Failed');
          }
        }
      }
    } catch (e) {
      log(e.toString());
      snackbarService.showSnackBar('Failed');
    } finally {
      ref.read(loadingProvider.notifier).stopLoading();
    }
  }
}
