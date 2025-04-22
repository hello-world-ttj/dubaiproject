import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 53,
                  width: 53,
                  child: Image.asset('assets/png/Logo.png'),
                ),
                Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.0,
                    letterSpacing: 0.16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Details',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1.0, // Equivalent to 100% line-height
                      letterSpacing: -0.2, // Approx. -1% of 20px font size
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 60,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Ann Mariya',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 1.0,
                  letterSpacing: -0.2,
                ),
              ),
              Row(
                children: [
                  Text(
                    'UI/UX Designer',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.0, // Equivalent to 100% line height
                      letterSpacing: 0.16, // 1% of 16px
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Xyvin Technologies',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.0, // 100% line height
                      letterSpacing: 0.16, // 1% of 16px
                    ),
                    textAlign: TextAlign.center, // optional
                  )
                ],
              ),
              Text(
                'UI/UX Designer focused on simple, intuitive, and user-friendly designs.',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400, // Regular weight
                  fontSize: 14,
                  height: 1.0, // 100% line height
                  letterSpacing: 0.14, // 1% of 14px
                ),
                textAlign: TextAlign.start, // Optional
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                 Image.asset('assets/png/phone.png'),
                  SizedBox(width: 10,),
                  Text(
  '+91 9458652637',
  style: TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0, // 100% line height
    letterSpacing: 0.0, // 0% = no extra spacing
  ),
)

                ],

              ),
              SizedBox(height: 10,),
                Row(
                children: [
                 Image.asset('assets/png/phone.png'),
                  SizedBox(width: 10,),
                  Text(
  '+91 9458652637',
  style: TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0, // 100% line height
    letterSpacing: 0.0, // 0% = no extra spacing
  ),
)

                ],

              ),
              SizedBox(height: 10,),
                Row(
                children: [
                 Image.asset('assets/png/phone.png'),
                  SizedBox(width: 10,),
                  Text(
  '+91 9458652637',
  style: TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0, // 100% line height
    letterSpacing: 0.0, // 0% = no extra spacing
  ),
)

                ],

              ),
              SizedBox(height: 10,),
                Row(
                children: [
                 Image.asset('assets/png/phone.png'),
                  SizedBox(width: 10,),
                  Text(
  '+91 9458652637',
  style: TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0, // 100% line height
    letterSpacing: 0.0, // 0% = no extra spacing
  ),
)

                ],

              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
