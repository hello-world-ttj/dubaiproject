import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/dialogs/premium_dialog.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/business_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/bussiness_products/business_view.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/bussiness_products/product_view.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/chat/chat_dash.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/chat/members.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PeoplePage extends ConsumerStatefulWidget {
  const PeoplePage({super.key});

  @override
  ConsumerState<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends ConsumerState<PeoplePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userAsync.whenOrNull(data: (user) {
        if (user.status == 'trial') {
          showDialog(
            context: context,
            builder: (_) => const PremiumDialog(),
          );
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Custom Tab Bar
                  Row(
                    children: [
                      _buildTabItem(0, "Members"),
                      _buildTabItem(1, "Chats"),
                    ],
                  ),
                  // Custom Indicator
                  CustomTabIndicator(selectedIndex: _selectedIndex),
                ],
              ),
            ),
            // Content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  MembersPage(),
                  ChatDash(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? kPrimaryColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
