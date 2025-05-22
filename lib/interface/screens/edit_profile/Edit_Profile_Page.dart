import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:flutter/material.dart';

import '../../components/buttons/GradientButton.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController webController = TextEditingController();

  bool businessSocialToggle = true;
  bool certificateToggle = true;
  bool awardToggle = true;
  bool activateFormToggle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Curved AppBar
            Stack(
              children: [
                Container(
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Image(
                            image: AssetImage(
                                'assets/png/Logo.png'), // Replace with your logo
                            height: 40,
                          ),
                          Text(
                            "Complete Profile",
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.0, // Line height: 100%
                              letterSpacing: 0, // 0% letter-spacing
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Skip",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              height: 1.0, // line-height: 100%
                              letterSpacing: 0.16, // 1% of 16px = 0.16
                              color: Color(0xFF072182),
                            ),
                            textAlign: TextAlign
                                .center, // helps with vertical alignment in some layouts
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Personal Details',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 1.0, // 100% line height
                letterSpacing: -0.2, // -1% of 20px = -0.2
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color(0xFFE1E4FB),
                            width: 3), // soft blue border
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/profile.jpg'), // replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFE1E4FB), width: 2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.edit, // or use a custom pencil icon
                          color: Color(0xFF0027FF), // dark blue
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const TextFieldLabel(label: ' Name'),
            TextField(
              controller: TextEditingController(text: 'Emile Jane'),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F8FF), // light background
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFFE1E4FB), // soft blue border
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xFF0027FF),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const TextFieldLabel(label: 'Designation'),
            TextField(
              controller: TextEditingController(text: 'Enter Designation'),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F8FF), // light background
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFFE1E4FB), // soft blue border
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Color(0xFF0027FF), // primary blue on focus (optional)
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const TextFieldLabel(label: 'Company'),
            TextField(
              controller: TextEditingController(text: 'Select'),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F8FF), // light background
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFFE1E4FB), // soft blue border
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Color(0xFF0027FF), // primary blue on focus (optional)
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const TextFieldLabel(label: 'Bio'),

            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
                filled: true,
                fillColor: kFillColor,
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFFE0E0E0), // light grey border
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFFE0E0E0), // same light grey border
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFF0027FF), // blue when focused
                    width: 1.5,
                  ),
                ),
              ),
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Contact Info',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 1.0, // line-height 100%
                letterSpacing: -0.01, // -1%
              ),
            ),

            SizedBox(height: 20),

            const TextFieldLabel(label: 'Mobile Number'),
            TextField(
              controller: TextEditingController(text: '6282569856'),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F8FF), // light background
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFFE1E4FB), // soft blue border
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Color(0xFF0027FF), // primary blue on focus (optional)
                    width: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            const TextFieldLabel(label: 'Email ID'),
            TextField(
              controller: TextEditingController(text: 'Enter Your Email'),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F8FF), // light background
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFFE1E4FB), // soft blue border
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Color(0xFF0027FF), // primary blue on focus (optional)
                    width: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            const TextFieldLabel(label: 'Country/Region'),
            TextField(
              controller: TextEditingController(text: 'Select'),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF6F8FF), // light background
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFFE1E4FB), // soft blue border
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color:
                        Color(0xFF0027FF), // primary blue on focus (optional)
                    width: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            const TextFieldLabel(label: 'Address'),

            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Your Adress',
                filled: true,
                fillColor: kFillColor,
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFFE0E0E0), // light grey border
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFFE0E0E0), // same light grey border
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Color(0xFF0027FF), // blue when focused
                    width: 1.5,
                  ),
                ),
              ),
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            Text(
              'Connected Accounts',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 1.0, // 100% line-height
                letterSpacing: -0.01, // -1% letter-spacing
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SwitchListTile(
              title: const Text(
                'Business Social Accounts',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              activeColor: const Color(0xFF0027FF),
              value: businessSocialToggle,
              onChanged: (value) {
                setState(() {
                  businessSocialToggle = value;
                });
              },
            ),

            /// Business Social Accounts
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: webController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/png/website.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  hintText: 'Link',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: webController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/png/Symbol.svg.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  hintText: 'Link',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: webController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/png/x.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  hintText: 'Link',
                  border: InputBorder.none,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add More',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.add, color: Colors.blue[900]),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SwitchListTile(
              title: const Text(
                'Certificates',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              activeColor: const Color(0xFF0027FF),
              value: businessSocialToggle,
              onChanged: (value) {
                setState(() {
                  businessSocialToggle = value;
                });
              },
            ),
            Container(
              height: 150, // You can adjust height as needed
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F8FF), // Light blue background
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.blue.shade100), // Optional border
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Certificates",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SwitchListTile(
              title: const Text(
                'Enter Awards',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              activeColor: const Color(0xFF0027FF),
              value: businessSocialToggle,
              onChanged: (value) {
                setState(() {
                  businessSocialToggle = value;
                });
              },
            ),
            Container(
              height: 150, // You can adjust height as needed
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F8FF), // Light blue background
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Colors.blue.shade100), // Optional border
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Certificates",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SwitchListTile(
              title: const Text(
                'Activate Form',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              activeColor: const Color(0xFF0027FF),
              value: businessSocialToggle,
              onChanged: (value) {
                setState(() {
                  businessSocialToggle = value;
                });
              },
            ),
            const SizedBox(height: 16),

            GradientButton(
              title: 'Save Details',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  final String label;
  const TextFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.0, // 100% line height
            letterSpacing: 0.16, // 1% of 16px = 0.16
          ),
          textAlign: TextAlign.start,
        ));
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  const CustomTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: TextEditingController(text: 'Emile Jane'),
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF6F8FF), // light background
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), // rounded corners
              borderSide: BorderSide(
                color: Color(0xFFE1E4FB), // soft blue border
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color(0xFF0027FF), // primary blue on focus (optional)
                width: 1.5,
              ),
            ),
          ),
        ));
  }
}

class SwitchTile extends StatefulWidget {
  final String title;
  const SwitchTile({super.key, required this.title});

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Switch(
          value: value,
          onChanged: (val) {
            setState(() {
              value = val;
            });
          },
        )
      ],
    );
  }
}
