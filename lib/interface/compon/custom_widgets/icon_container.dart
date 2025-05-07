import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:flutter/material.dart';

class CustomIconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double padding;
  final double borderRadius;

  const CustomIconContainer({
    Key? key,
    required this.icon,
    this.iconColor = CommonColor.primaryColor,
    this.backgroundColor = CommonColor.greyLight,
    this.padding = 2.0,
    this.borderRadius = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
