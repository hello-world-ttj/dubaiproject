import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/interface/components/buttons/GradientButton.dart';
import 'package:flutter/material.dart';

import '../../../Data/utils/common_color.dart';
import '../TextFields/modal_textField.dart';

class ContactEditor extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;
  final void Function(String value) onSave;

  const ContactEditor({
    Key? key,
    required this.value,
    required this.icon,
    required this.onSave,
    required this.label,
  }) : super(key: key);

  @override
  _ContactEditorState createState() => _ContactEditorState();
}

class _ContactEditorState extends State<ContactEditor> {
  String? currentValue;
  NavigationService navigationService = NavigationService();
  @override
  void initState() {
    super.initState();

    final existing = widget.value != null;
    if (existing) currentValue = widget.value;
  }

  void _showEditModal() {
    TextEditingController textController =
        TextEditingController(text: currentValue);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Enable proper resizing when keyboard appears
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: kGreyDarker,
                          borderRadius: BorderRadius.circular(16)),
                      width: 70, // Width of the line
                      height: 4, // Thickness of the line
                    ),
                  ),
                ),
                CustomTextFormField(
                  textInputType: widget.label.toLowerCase().contains('whatsapp')
                      ? TextInputType.phone
                      : TextInputType.text,
                  labelText: 'Enter ${widget.label}',
                  textController: textController,
                ),
                if (widget.label.toLowerCase().contains('phone') ||
                    widget.label.toLowerCase().contains('whatsapp') ||
                    widget.label.toLowerCase().contains('number'))
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Enter with your country code',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                GradientButton(
                  title: 'Save',
                  onPressed: () {
                    widget.onSave(textController.text.trim());
                    setState(() {
                      currentValue = textController.text.trim().isNotEmpty
                          ? textController.text.trim()
                          : null;
                    });
                    navigationService.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isValuePresent = currentValue != null && currentValue!.isNotEmpty;

    return GestureDetector(
      onTap: _showEditModal,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kBorderColor),
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
            color: isValuePresent ? kPrimaryColor : kFillColor),
        padding: const EdgeInsets.all(16),
        child: Icon(
          widget.icon,
          color: isValuePresent ? kWhite : kPrimaryColor,
        ),
      ),
    );
  }
}
