import 'package:flutter/material.dart';

import 'bussiness_page.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Light background behind AppBar
        body: Column(
          children: [
            // Curved AppBar with only TabBar
            Container(
              height: 120,
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
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TabBar(
                    indicatorColor: Colors.blue.shade900,
                    indicatorWeight: 3,
                    labelColor: Colors.blue.shade900,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: 'Business'),
                      Tab(text: 'Products'),
                    ],
                  ),
                ),
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                BussinessPage(),
                  Center(
                    child: Text(
                      'Products Content',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
