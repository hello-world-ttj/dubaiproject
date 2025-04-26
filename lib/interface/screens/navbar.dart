import 'dart:developer';

import 'package:dubaiprojectxyvin/interface/Data/routes/nav_router.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/business_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/home_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/news_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/people_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconResolver extends StatelessWidget {
  final String iconPath;
  final Color color;
  final double height;
  final double width;

  const IconResolver({
    Key? key,
    required this.iconPath,
    required this.color,
    this.height = 20,
    this.width = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconPath.startsWith('http') || iconPath.startsWith('https')) {
      return Image.network(
        iconPath,
        // color: color,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
      );
    } else {
      return SvgPicture.asset(
        iconPath,
        color: color,
        height: height,
        width: width,
      );
    }
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  static List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      ref.read(selectedIndexProvider.notifier).updateIndex(index);
    });
  }

  List<String> _icons = [];

  Future<void> _initialize() async {
    _widgetOptions = <Widget>[
      HomePage(),
      BusinessPage(),
      ProfilePage(),
      NewsPage(),
      PeoplePage(),
    ];

    _icons = [
      'assets/svg/icons/home.svg',
      'assets/svg/icons/business.svg',
      'assets/svg/icons/news.svg',
      'assets/svg/icons/people.svg',
      'assets/svg/icons/dummy_person_small.svg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selectedIndex = ref.watch(selectedIndexProvider);
      _initialize();
      return PopScope(
        canPop: selectedIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          log('im inside mainpage popscope');
          if (selectedIndex != 0) {
            ref.read(selectedIndexProvider.notifier).updateIndex(0);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: _widgetOptions.elementAt(selectedIndex),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF092073), Color(0xFF1835A0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) {
                          final isSelected = selectedIndex == index;
                          final labels = [
                            'Home',
                            'Business',
                            'News',
                            'Members',
                            'Profile'
                          ];
                          return InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              HapticFeedback.selectionClick();
                              _onItemTapped(index);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                      begin: 1.0, end: isSelected ? 1.2 : 1.0),
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.elasticOut,
                                  builder: (context, scale, child) {
                                    return Transform.scale(
                                      scale: scale,
                                      child: child,
                                    );
                                  },
                                  child: IconResolver(
                                    iconPath: _icons[index],
                                    color: isSelected
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFFFFFFFF).withOpacity(.5),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  labels[index],
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(isSelected ? 1.0 : 0.6),
                                    fontSize: isSelected ? 14 : 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
