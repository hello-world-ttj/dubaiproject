import 'dart:async';
import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/models/event_model.dart';
import 'package:dubaiprojectxyvin/Data/models/news_model.dart';
import 'package:dubaiprojectxyvin/Data/models/promotion_model.dart';
import 'package:dubaiprojectxyvin/Data/routes/nav_router.dart';
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/services/webview.dart';
import 'package:dubaiprojectxyvin/interface/components/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/common_style.dart';
import 'package:dubaiprojectxyvin/interface/components/custom_widgets/custom_video.dart';
import 'package:dubaiprojectxyvin/interface/components/custom_widgets/event_widget.dart';
import 'package:dubaiprojectxyvin/interface/components/custom_widgets/news_card.dart';
import 'package:dubaiprojectxyvin/interface/screens/main_pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  int _currentBannerIndex = 0;
  int _currentNoticeIndex = 0;
  int _currentPosterIndex = 0;
  int _currentEventIndex = 0;
  int _currentVideoIndex = 0;

  double _calculateDynamicHeight(List<Promotion> notices) {
    double maxHeight = 0.0;

    for (var notice in notices) {
      // Estimate height based on the length of title and description
      final double titleHeight =
          _estimateTextHeight(notice.title!, 18.0); // Font size 18 for title
      final double descriptionHeight = _estimateTextHeight(
          notice.description!, 14.0); // Font size 14 for description

      final double itemHeight =
          titleHeight + descriptionHeight - 20; // Adding padding
      if (itemHeight > maxHeight) {
        maxHeight = itemHeight + MediaQuery.sizeOf(context).width * 0.05;
      }
    }
    return maxHeight;
  }

  double _estimateTextHeight(String text, double fontSize) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final int numLines = (text.length / (screenWidth / fontSize)).ceil();
    return numLines * fontSize * 1.2 + 40;
  }

  CarouselController controller = CarouselController();
  String? startDate;
  String? endDate;
  @override
  Widget build(BuildContext context) {
    final List<News> news = [
      News(
        category: "Technology",
        title: "New AI Breakthrough",
        content:
            "Researchers have made a significant breakthrough in AI technology.",
        media: "https://example.com/media/ai_news.jpg",
        status: "published",
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        updatedAt: DateTime.now(),
      ),
      News(
        category: "Health",
        title: "10 Tips for a Healthy Lifestyle",
        content:
            "Here are 10 practical tips to improve your daily health routine.",
        media: "https://example.com/media/health_tips.jpg",
        status: "published",
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        updatedAt: DateTime.now(),
      ),
      News(
        category: "Sports",
        title: "Local Team Wins Championship",
        content:
            "The underdog local team won the championship in a thrilling match.",
        media: "https://example.com/media/sports_win.jpg",
        status: "draft",
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        updatedAt: DateTime.now().subtract(Duration(days: 1)),
      ),
      News(
        category: "Business",
        title: "Startup Raises 10M in Funding",
        content: "A tech startup has secured 10 million in Series A funding.",
        media: "https://example.com/media/startup_funding.jpg",
        status: "published",
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        updatedAt: DateTime.now().subtract(Duration(days: 2)),
      ),
      News(
        category: "Entertainment",
        title: "New Movie Breaks Box Office Records",
        content:
            "The latest blockbuster has broken several box office records.",
        media: "https://example.com/media/movie_hit.jpg",
        status: "archived",
        createdAt: DateTime.now().subtract(Duration(days: 10)),
        updatedAt: DateTime.now().subtract(Duration(days: 5)),
      ),
    ];

    NavigationService navigationService = NavigationService();
    final List<Promotion> promotions = [
      Promotion(
        title: 'Important Notice',
        description:
            'We will be conducting maintenance on our servers this weekend.',
        type: 'notice',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 7)),
        media: null,
        link: 'https://example.com/notice',
      ),
      Promotion(
        title: 'New Product Poster',
        description: 'Check out our new range of eco-friendly products!',
        type: 'poster',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 30)),
        media: 'https://example.com/media/poster.jpg',
        link: 'https://example.com/products',
      ),
      Promotion(
        title: 'Summer Sale Banner',
        description: 'Up to 50% off on summer essentials!',
        type: 'banner',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 10)),
        media: 'https://example.com/media/banner.jpg',
        link: 'https://example.com/sale',
      ),
      Promotion(
        title: 'Watch Our Latest Video',
        description: 'Learn how to make the most out of our platform.',
        type: 'video',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 15)),
        media: 'https://example.com/media/video.mp4',
        link: 'https://youtube.com/watch?v=dQw4w9WgXcQ',
      ),
    ];

    return Consumer(
      builder: (context, ref, child) {
        final banners =
            promotions.where((promo) => promo.type == 'banner').toList();
        final notices =
            promotions.where((promo) => promo.type == 'notice').toList();
        final posters =
            promotions.where((promo) => promo.type == 'poster').toList();
        final videos =
            promotions.where((promo) => promo.type == 'video').toList();
        final filteredVideos =
            videos.where((video) => video.link!.startsWith('http')).toList();
        List<Event> events = [
          Event(
            id: '1',
            eventName: 'Tech Expo 2025',
            description: 'A grand event showcasing emerging tech innovations.',
            type: 'Exhibition',
            image: 'https://example.com/image1.jpg',
            startDate: DateTime(2025, 5, 10),
            eventDate: DateTime(2025, 5, 10),
            startTime: DateTime(2025, 5, 10, 10, 0),
            endDate: DateTime(2025, 5, 10),
            endTime: DateTime(2025, 5, 10, 16, 0),
            platform: 'Zoom',
            link: 'https://zoom.us/tech-expo',
            venue: 'Tech Park Auditorium',
            organiserName: 'InnovateX',
            coordinator: ['John Doe', 'Alice Smith'],
            speakers: [
              Speaker(
                name: 'Dr. Alan Turing',
                designation: 'AI Researcher',
                role: 'Keynote Speaker',
                image: 'https://example.com/speaker1.jpg',
              ),
              Speaker(
                name: 'Ada Lovelace',
                designation: 'Tech Evangelist',
                role: 'Panelist',
                image: 'https://example.com/speaker2.jpg',
              ),
            ],
            status: 'upcoming',
            rsvp: ['user1', 'user2'],
            attended: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            limit: 100,
          ),
          Event(
            id: '2',
            eventName: 'Design Sprint Workshop',
            description:
                'Hands-on session on problem-solving using design sprint methodology.',
            type: 'Workshop',
            image: 'https://example.com/image2.jpg',
            startDate: DateTime(2025, 6, 15),
            eventDate: DateTime(2025, 6, 15),
            startTime: DateTime(2025, 6, 15, 9, 30),
            endDate: DateTime(2025, 6, 15),
            endTime: DateTime(2025, 6, 15, 17, 0),
            platform: 'Google Meet',
            link: 'https://meet.google.com/design-sprint',
            venue: 'Innovation Lab, Floor 2',
            organiserName: 'Creative Minds',
            coordinator: ['Bob Marley'],
            speakers: [
              Speaker(
                name: 'Grace Hopper',
                designation: 'UX Specialist',
                role: 'Trainer',
                image: 'https://example.com/speaker3.jpg',
              ),
            ],
            status: 'upcoming',
            rsvp: ['user3', 'user4'],
            attended: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            limit: 50,
          ),
        ];

        return RefreshIndicator(
          color: Color(0xFF072182),
          onRefresh: () async {
            // ref.invalidate(fetchPromotionsProvider);
            // ref.invalidate(fetchEventsProvider);
          },
          child: AdvancedDrawer(
            drawer: customDrawer(context: context),
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: CommonColor.white),
            ),
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Scaffold(
              backgroundColor: CommonColor.white,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(80, 226, 226, 226),
                                offset: Offset(0, 1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SafeArea(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                     
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: InkWell(
                                        onTap: () => _advancedDrawerController
                                            .showDrawer(),
                                        child: SizedBox(
                                          width: 60,
                                          child: ValueListenableBuilder<
                                              AdvancedDrawerValue>(
                                            valueListenable:
                                                _advancedDrawerController,
                                            builder: (_, value, __) {
                                              return AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 250),
                                                child: const Icon(Icons.menu),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Consumer(
                                      builder: (context, ref, child) {
                                        return IconButton(
                                          icon: const Icon(Icons
                                              .notifications_none_outlined),
                                          onPressed: () {
                                            // Navigate to notifications
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                // Centered Logo
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WebViewScreen(
                                            color: Color(0xFF072182),
                                            url:
                                                'https://www.dubaiconnect.com/',
                                            title: 'Dubai Connect',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/png/Logo.png',
                                      scale: 5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text('Welcome, ${'USER NAME'}',
                              style: kLargeTitleB.copyWith(
                                color: CommonColor.primaryText,
                              )),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Connect with the Heart of Dubai’s Business World.',
                                  style: kSmallTitleUL.copyWith(
                                    color: CommonColor.primaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF274198), Color(0xFF0D1532)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Image.asset(
                                    'assets/png/trial_round.png',
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.lightbulb,
                                              color: Colors.amber[400],
                                              size: 24),
                                          const SizedBox(width: 10),
                                          const Expanded(
                                            child: Text(
                                              'Your 30-day free trial is active!',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Enjoy premium features and grow your business with Dubai Connect.',
                                        style: TextStyle(
                                          color: Color(0xFFC9D2F2),
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '10 days left — upgrade anytime!',
                                        style: const TextStyle(
                                          color: Color(0xFFB0B9D9),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      SizedBox(
                                        width: 130,
                                        height: 36,
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xFFE7ECFF)),
                                            foregroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xFF232C5B)),
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            navigationService
                                                .pushNamed('MySubscription');
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Subscribe',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_outward_outlined,
                                                  size: 16),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (banners.isNotEmpty)
                          Column(
                            children: [
                              CarouselSlider(
                                items: banners.map((banner) {
                                  return _buildBanners(
                                      context: context, banner: banner);
                                }).toList(),
                                options: CarouselOptions(
                                  height: 175,
                                  scrollPhysics: banners.length > 1
                                      ? null
                                      : const NeverScrollableScrollPhysics(),
                                  autoPlay: banners.length > 1 ? true : false,
                                  viewportFraction: 1,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentBannerIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 30),

                        if (notices.isNotEmpty)
                          Column(
                            children: [
                              CarouselSlider(
                                items: notices.map((notice) {
                                  return customNotice(
                                      context: context, notice: notice);
                                }).toList(),
                                options: CarouselOptions(
                                  scrollPhysics: notices.length > 1
                                      ? null
                                      : const NeverScrollableScrollPhysics(),
                                  autoPlay: notices.length > 1 ? true : false,
                                  viewportFraction: 1,
                                  height: _calculateDynamicHeight(notices),
                                  autoPlayInterval: const Duration(seconds: 3),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentNoticeIndex = index;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (notices.length > 1)
                                _buildDotIndicator(
                                    _currentNoticeIndex,
                                    notices.length,
                                    const Color.fromARGB(255, 39, 38, 38)),
                            ],
                          ),

                        if (posters.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                CarouselSlider(
                                  items: posters.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    Promotion poster = entry.value;

                                    return KeyedSubtree(
                                      key: ValueKey(index),
                                      child: customPoster(
                                          context: context, poster: poster),
                                    );
                                  }).toList(),
                                  options: CarouselOptions(
                                    height: 420,
                                    scrollPhysics: posters.length > 1
                                        ? null
                                        : const NeverScrollableScrollPhysics(),
                                    autoPlay: posters.length > 1,
                                    viewportFraction: 1,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentPosterIndex = index;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),

                        // Events Carousel

                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Text('Latest Events',
                                      style: kSubHeadingB.copyWith(
                                        color: Color(0xFF072182),
                                      )),
                                ),
                              ],
                            ),
                            CarouselSlider(
                              items: events.map((event) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: GestureDetector(
                                    onTap: () {
                                      navigationService.pushNamed(
                                          'ViewMoreEvent',
                                          arguments: event);
                                    },
                                    child: eventWidget(
                                      withImage: true,
                                      context: context,
                                      event: event,
                                    ),
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: 290,
                                scrollPhysics: events.length > 1
                                    ? null
                                    : const NeverScrollableScrollPhysics(),
                                autoPlay: events.length > 1 ? true : false,
                                viewportFraction: 1,
                                autoPlayInterval: const Duration(seconds: 3),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentEventIndex = index;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, right: 15),
                              child: Row(
                                children: [
                                  Text('Latest News',
                                      style: kSubHeadingB.copyWith(
                                          color: Color(0xFF072182))),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => ref
                                        .read(selectedIndexProvider.notifier)
                                        .updateIndex(3),
                                    child: const Text('see all',
                                        style: kSmallTitleR),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                itemCount: news.length,
                                itemBuilder: (context, index) {
                                  final individualNews = news[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: newsCard(
                                        onTap: () {
                                          ref
                                              .read(selectedIndexProvider
                                                  .notifier)
                                              .updateIndex(3);
                                        },
                                        imageUrl: individualNews.media ?? '',
                                        title: individualNews.title ?? '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        // Videos Carousel
                        if (filteredVideos.isNotEmpty)
                          Column(
                            children: [
                              CarouselSlider(
                                items: filteredVideos.map((video) {
                                  return customVideo(
                                      context: context, video: video);
                                }).toList(),
                                options: CarouselOptions(
                                  height: 225,
                                  scrollPhysics: videos.length > 1
                                      ? null
                                      : const NeverScrollableScrollPhysics(),
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentVideoIndex = index;
                                    });
                                  },
                                ),
                              ),
                              if (videos.length > 1)
                                _buildDotIndicator(_currentVideoIndex,
                                    filteredVideos.length, Colors.black),
                            ],
                          ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  // if (widget.user.isAdmin ?? false)
                  //   Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Align(
                  //       alignment: Alignment.bottomRight,
                  //       child: Container(
                  //         padding: const EdgeInsets.all(13),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: CommonColor.primaryColor,
                  //         ),
                  //         child: InkWell(
                  //           onTap: () {
                  //             navigationService
                  //                 .pushNamed('MemberCreation');
                  //           },
                  //           child: const Icon(
                  //             Icons.person_add_alt_1_outlined,
                  //             color: CommonColor.white,
                  //             size: 27,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Method to build a dot indicator for carousels
  Widget _buildDotIndicator(int currentIndex, int itemCount, Color color) {
    return Center(
      child: SmoothPageIndicator(
        controller: PageController(initialPage: currentIndex),
        count: itemCount,
        effect: WormEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: color,
          dotColor: Colors.grey,
        ),
      ),
    );
  }
}

Widget _buildBanners(
    {required BuildContext context, required Promotion banner}) {
  return Container(
    width: MediaQuery.sizeOf(context).width / 1.15,
    child: AspectRatio(
      aspectRatio: 2 / 1, // Custom aspect ratio as 2:1
      child: Stack(
        clipBehavior: Clip.none, // This allows overflow
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.network(
                banner.media ?? '',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customPoster({
  required BuildContext context,
  required Promotion poster,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10), // Apply the border radius here
      child: AspectRatio(
        aspectRatio: 19 / 20,
        child: Image.network(
          poster.media ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child; // Image loaded successfully
            }
            // While the image is loading, show shimmer effect
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget customNotice({
  required BuildContext context,
  required Promotion notice,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFCBD6FF), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, .1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/png/notice_background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Notice',
                                style: kSubHeadingB.copyWith(
                                    color: Color(0xFF072182)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Container(
                                  width: 70,
                                  height: 1,
                                  color: Color(0xFF072182)),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Text(
                                notice.title ?? '',
                                style:
                                    kSmallTitleB.copyWith(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Container(
                                  width: 70,
                                  height: 1,
                                  color: Color(0xFF072182)),
                            ),
                            const SizedBox(height: 8),
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: .9),
                              child: Text(
                                notice.description?.trim() ?? '',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
