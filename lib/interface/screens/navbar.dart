import 'dart:async';
import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/user_notifier.dart';
import 'package:dubaiprojectxyvin/Data/routes/nav_router.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/shimmers/promotion_shimmers.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/bussiness/Tab_bar.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/home_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/news_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/people_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/profile_page.dart';
import 'package:dubaiprojectxyvin/interface/screens/onboarding/welcome_screen.dart';
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

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  static List<Widget> _widgetOptions = <Widget>[];

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  Timer? _inactivityTimer;

  final Duration _inactivityDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _startInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      ref.read(selectedIndexProvider.notifier).updateIndex(index);
    });

    _resetInactivityTimer();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, () {
      _animationController.forward();
    });
  }

  void _resetInactivityTimer() {
    _animationController.reverse();

    _startInactivityTimer();
  }

  List<String> _icons = [];
  Future<void> _initialize({required UserModel user}) async {
    _widgetOptions = <Widget>[
      HomePage(
        user: user,
      ),
      TabBarPage(),
      NewsPage(),
      PeoplePage(),
      ProfilePage(
        user: user,
      ),
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
      final asyncUser = ref.watch(userProvider);
      final selectedIndex = ref.watch(selectedIndexProvider);
    return  asyncUser.when(
        data: (user) {    _initialize(user: user);
          return PopScope(
            canPop: selectedIndex == 0,
            onPopInvokedWithResult: (didPop, result) {
              log('im inside mainpage popscope');
              if (selectedIndex != 0) {
                ref.read(selectedIndexProvider.notifier).updateIndex(0);
              }
            },
            child: GestureDetector(
              onTap: _resetInactivityTimer,
              onPanDown: (_) => _resetInactivityTimer(),
              onPanUpdate: (_) => _resetInactivityTimer(),
              behavior: HitTestBehavior.translucent,
              child: Scaffold(
                body: Stack(
                  children: [
                    Center(
                      child: _widgetOptions.elementAt(selectedIndex),
                    ),
                    // Animated navbar using SlideTransition
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 24),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                              begin: 1.0,
                                              end: isSelected ? 1.2 : 1.0),
                                          duration:
                                              const Duration(milliseconds: 350),
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
                                                : Color(0xFFFFFFFF)
                                                    .withOpacity(.5),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          labels[index],
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                                isSelected ? 1.0 : 0.6),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () {
          log('im inside details main page loading');
          return Scaffold(
              backgroundColor: kPrimaryLightColor,
              body: buildShimmerPromotionsColumn(context: context));
        },
        error: (error, stackTrace) {
          log('im inside details main page error $error $stackTrace');
          return WelcomeScreen();
        },
      );
  
    });
  }
}
