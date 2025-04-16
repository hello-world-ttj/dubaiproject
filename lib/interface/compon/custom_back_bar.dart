import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: CommonColor.lightBlueBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
            width: 1.5, 
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFF072182),
            size: 24,
          ),
        ),
      ),
    );
  }
}
