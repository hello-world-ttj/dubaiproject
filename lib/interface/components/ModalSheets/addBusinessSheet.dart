import 'dart:io';
import 'package:dubaiprojectxyvin/Data/services/api_routes/business_api/business_api.dart';
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/services/snackbar_service.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/buttons/GradientButton.dart';
import 'package:dubaiprojectxyvin/interface/components/loading_indicator.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:dubaiprojectxyvin/Data/services/image_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class ShowAdddBusinessSheet extends StatefulWidget {
  final Future<File?> Function() pickImage;
  final TextEditingController textController;

  const ShowAdddBusinessSheet({
    Key? key,
    required this.pickImage,
    required this.textController,
  }) : super(key: key);

  @override
  State<ShowAdddBusinessSheet> createState() => _ShowAdddBusinessSheetState();
}

class _ShowAdddBusinessSheetState extends State<ShowAdddBusinessSheet> {
  File? selectedImage;
  String? selectedType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? mediaUrl;
  final cropController = CustomImageCropController();

  Future<void> _handleImagePick(BuildContext context) async {
    final File? pickedImage = await ImageService.pickAndCropImage(
      context: context,
      cropController: cropController,
      source: ImageSource.gallery,
      ratio: Ratio(width: 4, height: 5),
      shape: CustomCropShape.Ratio,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = NavigationService();
    SnackbarService snackbarService = SnackbarService();
    return PopScope(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
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
                      'Add Business',
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
                const SizedBox(height: 20),
                FormField<File>(
                  initialValue: selectedImage,
                  builder: (FormFieldState<File> state) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => _handleImagePick(context),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [8, 4],
                            color: state.hasError
                                ? Colors.red
                                : const Color.fromARGB(255, 158, 158, 158),
                            child: Container(
                              width: double.infinity,
                              height: 110,
                              color: Colors.grey[200],
                              child: selectedImage == null
                                  ? const Center(
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
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Image.file(
                                              selectedImage!,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                selectedImage = null;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
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
                TextFormField(
                  controller: widget.textController,
                  maxLines: ((MediaQuery.sizeOf(context).height) / 150).toInt(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Add content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GradientButton(
                  title: 'POST',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: LoadingAnimation()),
                      );

                      try {
                        print(selectedType);

                        if (selectedImage != null) {
                          mediaUrl = await ImageService.imageUpload(
                            selectedImage!.path,
                          );
                        }

                        await BusinessApiService.uploadBusiness(
                          media: mediaUrl,
                          content: widget.textController.text,
                        );
                        widget.textController.clear();
                        selectedImage = null;

                        navigationService.pop();
                        snackbarService.showSnackBar(
                            'Your Post Will Be Reviewed By Admin');
                      } finally {
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
