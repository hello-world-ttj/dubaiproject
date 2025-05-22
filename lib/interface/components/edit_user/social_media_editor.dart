import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/buttons/GradientButton.dart';
import 'package:flutter/material.dart';

import '../../../Data/services/navigation_service.dart';
import '../TextFields/modal_textField.dart';

class SocialMediaEditor extends StatefulWidget {
  final List<Link> socialMedias;
  final String platform;
  final IconData icon;
  final void Function(List<Link> socialMedias, String platform, String newUrl)
      onSave;

  const SocialMediaEditor({
    Key? key,
    required this.socialMedias,
    required this.platform,
    required this.icon,
    required this.onSave,
  }) : super(key: key);

  @override
  _SocialMediaEditorState createState() => _SocialMediaEditorState();
}

class _SocialMediaEditorState extends State<SocialMediaEditor> {
  String? currentValue;
  NavigationService navigationService = NavigationService();
  @override
  void initState() {
    super.initState();
    // Fetch the existing value for the platform, if it exists
    final existing = widget.socialMedias.firstWhere(
        (link) => link.name == widget.platform,
        orElse: () => Link(name: null, link: null));
    currentValue = existing.link;
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
                      // Line color
                    ),
                  ),
                ),
                CustomTextFormField(
                  labelText: 'Enter URL for ${widget.platform}',
                  textController: textController,
                ),
                const SizedBox(height: 16),
                GradientButton(
                  title: 'Save',
                  onPressed: () {
                    widget.onSave(widget.socialMedias, widget.platform,
                        textController.text.trim());
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

    return Container(
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
    );
  }
}
