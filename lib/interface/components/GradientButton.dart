import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color buttonSideColor;
  final Color labelColor;
  final double labelFontSize;
  final double height;
  final bool isLoading;
  final List<Color>? gradientColors;
  final Color? solidColor; 
  final double width;

  const GradientButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonSideColor = Colors.transparent,
    this.labelColor = Colors.white,
    this.labelFontSize = 16.0,
    this.isLoading = false,
    this.height = 45.0,
    this.gradientColors,
    this.solidColor,
    this.width = 380,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: solidColor, // Will be ignored if gradient is present
        gradient: gradientColors != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors!,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
        border: buttonSideColor != Colors.transparent
            ? Border.all(color: buttonSideColor)
            : null,
      ),
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.white,
          backgroundColor: solidColor != null && gradientColors == null
              ? solidColor
              : Colors.transparent, // Prevent default background if gradient
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: labelFontSize,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: labelColor,
                ),
              ),
      ),
    );
  }
}
