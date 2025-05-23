import 'dart:io';
import 'package:dubaiprojectxyvin/Data/services/api_routes/user_api/user_data/edit_user.dart';
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/loading_notifier.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_style.dart';
import 'package:dubaiprojectxyvin/interface/components/textFormFields/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import '../../components/buttons/GradientButton.dart';
import '../../components/buttons/custom_back_button.dart';
import '../../../Data/services/image_service.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  File? _selectedImage;
  final _cropController = CustomImageCropController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final File? croppedImage = await MediaService.pickAndCropImage(
      context: context,
      cropController: _cropController,
      ratio: Ratio(width: 1, height: 1),
      shape: CustomCropShape.Circle,
    );

    if (croppedImage != null) {
      setState(() {
        _selectedImage = croppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer(
        builder: (context, ref, child) {
          return Scaffold(
            backgroundColor: kWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(
                              onTap: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: kGreyLight,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                            Text(
                              'CREATE YOUR ACCOUNT',
                              style: kSmallerTitleR.copyWith(color: kGreyLight),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: kGreyLight,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  child: _selectedImage != null
                                      ? ClipOval(
                                          child: Image.file(
                                            _selectedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                              width: 1,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.person_outline,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF27409A),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Name',
                          style: kBodyTitleR,
                        ),
                        const SizedBox(height: 4),
                        CustomTextFormField(
                          labelText: 'Enter your full name',
                          textController: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Email ID',
                          style: kBodyTitleR,
                        ),
                        const SizedBox(height: 4),
                        CustomTextFormField(
                          textController: _emailController,
                          labelText: 'Enter your email id',
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Bio',
                          style: kBodyTitleR,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          maxLines: 3,
                          textController: _bioController,
                          labelText: 'Enter your bio',
                        ),
                        const SizedBox(height: 24),
                        // const Text(
                        //   'Company',
                        //   style: kBodyTitleR,
                        // ),
                        // const SizedBox(height: 8),
                        // CustomTextFormField(
                        //   textController: _companyController,
                        //   labelText: 'Enter Your company name',
                        // ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: GradientButton(
                            title: 'Sent Request',
                            isLoading: isLoading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(loadingProvider.notifier)
                                    .startLoading();
                                try {
                                  if (_selectedImage != null) {
                                    MediaService.mediaUpload(
                                        _selectedImage!.path);
                                  }
                                  await editUser({
                                    "name": _nameController.text,
                                    "email": _emailController.text,
                                    "bio": _bioController.text,
                                  });
                                  NavigationService navigationService =
                                      NavigationService();
                                  navigationService
                                      .pushNamedReplacement('MainPage');
                                } finally {
                                  ref
                                      .read(loadingProvider.notifier)
                                      .stopLoading();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _companyController.dispose();
    super.dispose();
  }
}
