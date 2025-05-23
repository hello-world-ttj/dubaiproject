import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color(0xFF274198).withOpacity(0.05),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Color(0x2741980D),
            width: 1,
          ),
        ),
        child: Center(child: Image.asset('assets/png/appbarbackbotton.png')),
      ),
    );
  }
}
