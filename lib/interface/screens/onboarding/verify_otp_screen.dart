import 'dart:async';
import 'dart:developer';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_style.dart';
import 'package:dubaiprojectxyvin/Data/utils/globals.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/loading_notifier.dart';
import 'package:dubaiprojectxyvin/Data/services/api_routes/user_api/login/user_login_api.dart';
import 'package:dubaiprojectxyvin/Data/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../components/buttons/GradientButton.dart';
import '../../components/buttons/custom_back_button.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String verificationId;
  final String resendToken;
  final String phone;
  const VerifyOtpScreen(
      {required this.verificationId,
      required this.resendToken,
      required this.phone,
      super.key});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  Timer? _timer;
  int _remainingTime = 60;
  bool canResend = false;
  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _remainingTime = 60;
      canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    errorController?.close();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);
    return Container(
      decoration: const BoxDecoration(
        gradient: scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  CustomBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/icons/verify_otp.svg',
                          height: 300,
                        ),
                        Positioned(
                          top: 70,
                          left: 20,
                          child: Image.asset(
                            'assets/gif/otp.gif',
                            width: 110,
                            height: 110,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text('Verify your OTP',
                      style: kLargeTitleB.copyWith(
                        fontSize: 25,
                        color: Color(0xFF27409A),
                      )),
                  const SizedBox(height: 16),
                  Text(
                    'Enter the OTP sent to +${widget.phone}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 45,
                        activeFillColor: const Color(0xFFF4F7FF),
                        inactiveFillColor: const Color(0xFFF4F7FF),
                        selectedFillColor: const Color(0xFFF4F7FF),
                        activeColor: const Color(0xFFE5ECFF),
                        inactiveColor: const Color(0xFFE5ECFF),
                        selectedColor: const Color(0xFF27409A),
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Resend OTP in ${_remainingTime.toString().padLeft(2, '0')} seconds',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: canResend
                            ? () {
                                startTimer();
                                // Add resend OTP logic here
                              }
                            : null,
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: canResend
                                ? const Color(0xFF27409A)
                                : Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GradientButton(
                      isLoading: isLoading,
                      title: 'Confirm',
                      onPressed: () {
                        if (currentText.length != 6) {
                          errorController?.add(ErrorAnimationType.shake);
                          setState(() => hasError = true);
                        } else {
                          setState(() => hasError = false);

                          if (!isLoading) {
                            _handleOtpVerification(context, ref);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleOtpVerification(
      BuildContext context, WidgetRef ref) async {
    ref.read(loadingProvider.notifier).startLoading();

    try {
      print(_otpController.text);

      Map<String, dynamic> responseMap = await verifyOTP(
          verificationId: widget.verificationId,
          fcmToken: fcmToken,
          smsCode: _otpController.text,
          context: context);

      String savedToken = responseMap['token'];
      String savedId = responseMap['userId'];
      Navigator.of(context).pushNamed('CreateAccountScreen');
      if (savedToken.isNotEmpty && savedId.isNotEmpty) {
        await SecureStorage.write('token', savedToken);
        await SecureStorage.write('id', savedId);
        token = savedToken;
        id = savedId;
        log('savedToken: $savedToken');
        log('savedId: $savedId');
      } else {
        // CustomSnackbar.showSnackbar(context, 'Wrong OTP');
      }
    } catch (e) {
      log(e.toString());
      // CustomSnackbar.showSnackbar(context, 'Wrong OTP');
    } finally {
      ref.read(loadingProvider.notifier).stopLoading();
    }
  }
}
