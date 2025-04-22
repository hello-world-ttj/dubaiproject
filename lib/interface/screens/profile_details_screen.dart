import 'package:flutter/material.dart';

class ProfilePreviewPage extends StatelessWidget {
  const ProfilePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Edit action
        },
        child: const Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Curved AppBar
            Stack(
              children: [
                Container(
                  height: 125,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Image(
                          image: AssetImage(
                              'assets/png/Logo.png'), // Replace with your logo
                          height: 40,
                        ),
                        Text(
                          "Profile Preview",
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
                            color: Colors.black,
                          ),
                          textAlign: TextAlign
                              .center, // helps with vertical alignment in some layouts
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Profile Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 88,
                    backgroundImage:
                        AssetImage('assets/profile.jpg'), // Your image here
                  ),
                  SizedBox(height: 10),
                  Text(
                    "JOHN FLITZGERALD", // manually uppercased
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1.0, // line-height: 100%
                      letterSpacing: 0.2, // 1% of 20px = 0.2
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Chief Financial Officer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.0, // line-height: 100%
                      letterSpacing: 0, // 0% letter spacing
                      color: Color(0xFF242424), // Hex color #242424
                    ),
                  ),
                  Text(
                    "Company Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.0, // line-height: 100%
                      letterSpacing: 0, // 0% letter spacing
                      color: Color(0x99242424), // #242424 with 60% opacity
                    ),
                  )
                ],
              ),
            ),

            // About Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.0, // line-height: 100%
                      letterSpacing: 0, // 0% letter spacing
                      color: Color(0xFF242424), // #242424
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0, // line-height: 100%
                      letterSpacing: 0, // 0% letter spacing
                      color: Color(0xFF242424), // #242424
                    ),
                  )
                ],
              ),
            ),

            // Contact Info Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  contactRow(Icons.phone, "+91 5458562637"),
                  contactRow(Icons.phone, "+91 9458582637"),
                  contactRow(Icons.phone, "+91 3458562637"),
                  contactRow(Icons.email, "johndoe@gmail.com"),
                  contactRow(Icons.location_on, "Lorem ipsum street, city."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
