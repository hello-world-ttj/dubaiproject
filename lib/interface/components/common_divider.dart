import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  final double width;
  final double thickness;
  final Color color;
  final double indent;
  final double endIndent;

  const CommonDivider({
    Key? key,
    this.width = 134, // Default width
    this.thickness = 5, // Default thickness
    this.color = Colors.black, // Default color
    this.indent = 9, // Default indent
    this.endIndent = 9, // Default end indent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
