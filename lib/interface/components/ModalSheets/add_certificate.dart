import 'dart:io';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/buttons/GradientButton.dart';
import 'package:flutter/material.dart';

import '../TextFields/modal_textField.dart';
import '../loading_indicator.dart';

class ShowAddCertificateSheet extends StatefulWidget {
  final TextEditingController textController;
  final String imageType;
  final String? imageUrl;
  final Future<File?> Function({required String imageType}) pickImage;
  final Future<void> Function() addCertificateCard;

  ShowAddCertificateSheet({
    super.key,
    required this.textController,
    required this.imageType,
    required this.pickImage,
    required this.addCertificateCard,
    this.imageUrl,
  });

  @override
  State<ShowAddCertificateSheet> createState() =>
      _ShowAddCertificateSheetState();
}

class _ShowAddCertificateSheetState extends State<ShowAddCertificateSheet> {
  File? certificateImage;
  final _formKey = GlobalKey<FormState>();
  bool get isEditMode => widget.imageUrl != null;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        widget.textController.text = '';
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Certificates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FormField<File>(
                initialValue: certificateImage,
                validator: (value) {
                  if (isEditMode && certificateImage == null) {
                    return null;
                  }
                  if (!isEditMode && value == null && widget.imageUrl == null) {
                    return 'Please upload an image';
                  }
                  return null;
                },
                builder: (FormFieldState<File> state) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final pickedFile = await widget.pickImage(
                              imageType: widget.imageType);
                          if (pickedFile == null) {
                            return; // Don't pop if no image selected
                          }
                          setState(() {
                            certificateImage = pickedFile;
                            state.didChange(
                                pickedFile); // Update form field state
                          });
                        },
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: state.hasError
                                ? Border.all(color: Colors.red)
                                : null,
                          ),
                          child: certificateImage == null
                              ? widget.imageUrl != null
                                  ? Center(
                                      child:
                                          Image.network(widget.imageUrl ?? ''),
                                    )
                                  : const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              size: 27, color: kPrimaryColor),
                                          SizedBox(height: 10),
                                          Text(
                                            'Upload Image',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 102, 101, 101)),
                                          ),
                                        ],
                                      ),
                                    )
                              : Center(
                                  child: Image.file(
                                    certificateImage!,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ModalSheetTextFormField(
                label: 'Add Name',
                textController: widget.textController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              GradientButton(                labelFontSize: 16,
                title: isEditMode ? 'UPDATE' : 'SAVE',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: LoadingAnimation()),
                    );

                    try {
                      if (isEditMode) {
                          await widget.addCertificateCard();
                      } else {
                        await widget.addCertificateCard();
                      }

                      widget.textController.clear();

                      if (certificateImage != null) {
                        setState(() {
                          certificateImage =
                              null; 
                        });
                      }
                    } catch (e) {
                      print('Error updating certificate: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Failed to update certificate: $e')),
                      );
                    } finally {
                      Navigator.of(context).pop(); // Close loading dialog
                      Navigator.pop(context); // Close modal sheet
                    }
                  }
                },

              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
