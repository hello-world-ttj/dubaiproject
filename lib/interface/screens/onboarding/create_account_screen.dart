import 'dart:io';
import 'package:dubaiprojectxyvin/Data/common_color.dart';
import 'package:dubaiprojectxyvin/Data/common_style.dart';
import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/loading_notifier.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/GradientButton.dart';
import '../../components/custom_back_bar.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  File? _selectedImage;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: CommonColor.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                        const Text(
                          'CREATE YOUR ACCOUNT',
                          style: kSmallTitleM,
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
                      style: kBodyTitleM,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: kBodyTitleR,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
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
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Email ID',
                      style: kBodyTitleM,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      style: kBodyTitleR,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email id',
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
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Designation',
                      style: kBodyTitleM,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _designationController,
                      style: kBodyTitleR,
                      decoration: InputDecoration(
                        hintText: 'Enter your Designation',
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
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Company',
                      style: kBodyTitleM,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _companyController,
                      style: kBodyTitleR,
                      decoration: InputDecoration(
                        hintText: 'Select',
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
                      ),
                    ),
                    const SizedBox(height: 40),
                    GradientButton(
                      title: 'Sent Request',
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ref.read(loadingProvider.notifier).startLoading();
                          try {
                            // Update user information
                            ref.read(userProvider.notifier).updateName(
                              name: _nameController.text,
                            );
                            
                            if (_emailController.text.isNotEmpty) {
                              ref.read(userProvider.notifier).updateEmail(
                                _emailController.text,
                              );
                            }

                            if (_designationController.text.isNotEmpty && _companyController.text.isNotEmpty) {
                              ref.read(userProvider.notifier).updateCompany(
                                Company(
                                  designation: _designationController.text,
                                  name: _companyController.text,
                                ),
                                0,
                              );
                            }

                            // Navigate to main page
                            Navigator.pushReplacementNamed(context, 'MainPage');
                          } finally {
                            ref.read(loadingProvider.notifier).stopLoading();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _designationController.dispose();
    _companyController.dispose();
    super.dispose();
  }
} 