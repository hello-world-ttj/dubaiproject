import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
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
       hintStyle: kSmallTitleUL,
                filled: true,
                fillColor: const Color(0xFFF4F7FF),
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
                  borderSide: const BorderSide(color: Color(0xFF27409A)),
                ),
                errorMaxLines: 2,
                hintText: label,
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF27409A)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF27409A)),
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
                switch (labelText) {
                  case 'Enter your Name':
                    ref.read(userProvider.notifier).updateName(
                          name: textController!.text,
                        );
                    break;

                  case 'Enter Personal Address':
                    ref
                        .read(userProvider.notifier)
                        .updateAddress(textController!.text);
                    break;

                  case 'Enter Designation':
                    ref.read(userProvider.notifier).updateCompany(
                          Company(designation: textController!.text),
                          companyIndex!,
                        );
                    break;

                  case 'Bio':
                    ref
                        .read(userProvider.notifier)
                        .updateBio(textController!.text);
                    break;

                  case 'Enter Company Name':
                    ref.read(userProvider.notifier).updateCompany(
                          Company(name: textController!.text),
                          companyIndex!,
                        );
                    break;

                  case 'Enter Company Email':
                    ref.read(userProvider.notifier).updateCompany(
                          Company(email: textController!.text),
                          companyIndex!,
                        );
                    break;

                  case 'Enter Company Phone':
                    ref.read(userProvider.notifier).updateCompany(
                          Company(phone: textController!.text),
                          companyIndex!,
                        );
                    break;

                  case 'Enter Company Website':
                    ref.read(userProvider.notifier).updateCompany(
                          Company(websites: textController!.text),
                          companyIndex!,
                        );
                    break;

                  case 'Enter Instagram':
                    ref.read(userProvider.notifier).updateSocialMedia(
                        [...?ref.read(userProvider).value?.social],
                        'instagram',
                        textController!.text);
                    break;

                  case 'Enter Linkedin':
                    ref.read(userProvider.notifier).updateSocialMedia(
                        [...?ref.read(userProvider).value?.social],
                        'linkedin',
                        textController!.text);
                    break;

                  case 'Enter Twitter':
                    ref.read(userProvider.notifier).updateSocialMedia(
                        [...?ref.read(userProvider).value?.social],
                        'twitter',
                        textController!.text);
                    break;

                  case 'Enter Facebook':
                    ref.read(userProvider.notifier).updateSocialMedia(
                        [...?ref.read(userProvider).value?.social],
                        'facebook',
                        textController!.text);
                    break;

                  default:
                }
              },
              readOnly: readOnly,
              controller: textController,
              maxLines: maxLines,
              validator: validator,
              decoration: InputDecoration(
                hintStyle: kSmallTitleUL,
                filled: true,
                fillColor: const Color(0xFFF4F7FF),
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
                  borderSide: const BorderSide(color: Color(0xFF27409A)),
                ),
                errorMaxLines: 2,
                hintText: labelText,
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF27409A)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF27409A)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
