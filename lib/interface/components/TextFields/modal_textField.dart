import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModalSheetTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String? label;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool isAward;
  final TextInputType textInputType;
  const ModalSheetTextFormField({
    required this.textController,
    required this.label,
    this.maxLines = 1,
    this.validator,
    super.key,
    this.isAward = false,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      maxLength: isAward ? 15 : null,
      controller: textController,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey, // Set the border color to light grey
            width: 1.0, // You can adjust the width as needed
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 185, 181, 181),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 185, 181, 181),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool readOnly;
  final int maxLines;
  final TextEditingController? textController;
  final int? companyIndex;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onChanged;
  final bool? enabled;
  final bool? isAward;
  final String? title;
  final TextInputType textInputType;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.readOnly = false,
    this.maxLines = 1,
    required this.textController,
    this.validator,
    this.onChanged,
    this.enabled,
    this.isAward,
    this.title,
    this.textInputType = TextInputType.text,
    this.companyIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          children: [
            if (title != null)
              Row(
                children: [
                  Text(
                    title ?? '',
                    style: kBodyTitleR,
                  ),
                ],
              ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: textInputType,
              enabled: enabled,
              onChanged: (value) {
                log(companyIndex.toString());
              },
              readOnly: readOnly,
              controller: textController,
              maxLines: maxLines,
              validator: validator,
              decoration: InputDecoration(
                hintStyle:
                    TextStyle(color: kGreyText.withOpacity(0.5), fontSize: 14),
                hintText: labelText,
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: kFillColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: kBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: kBorderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: kBorderColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: kBorderColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
