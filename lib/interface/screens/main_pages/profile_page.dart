import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/services/extract_level_details.dart';
import 'package:dubaiprojectxyvin/Data/services/navigation_service.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_style.dart';
import 'package:dubaiprojectxyvin/interface/components/custom_widgets/contact_row.dart';
import 'package:dubaiprojectxyvin/interface/components/custom_widgets/glowing_animated_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ProfilePage extends ConsumerWidget {
  final UserModel user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NavigationService navigationService = NavigationService();
    final designations = user.company!
        .map((i) => i.designation)
        .where((d) => d != null && d.isNotEmpty)
        .map((d) => d!)
        .toList();

    final companyNames = user.company!
        .map((i) => i.name)
        .where((n) => n != null && n.isNotEmpty)
        .map((n) => n!)
        .toList();
    String joinedDate = DateFormat('dd/MM/yyyy').format(user.createdAt!);
    Map<String, String> levelData = extractLevelDetails(user.level ?? '');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 0),
          child:
              Container(width: double.infinity, height: 1, color: kGreyLight),
        ),
        backgroundColor: kWhite,
        title: Text(
          'Profile',
          style: kSubHeadingL,
        ),
      ),
      backgroundColor: kPrimaryLightColor,
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(26.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 237, 231, 231)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF0B96F5).withOpacity(.67),
                                    Color(0xFF0C1E8A).withOpacity(.67),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 182, 181, 181)
                                            .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(.5, .5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFFFFF)
                                                  .withOpacity(.54),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: kPrimaryColor,
                                            ),
                                            onPressed: () {
                                              navigationService.pushNamed(
                                                  'ProfilePreviewUsingID',
                                                  arguments: user.uid);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double
                                            .infinity, // Sets a bounded width constraint
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            GlowingAnimatedAvatar(
                                              imageUrl: user.image,
                                              defaultAvatarAsset:
                                                  'assets/svg/icons/dummy_person_large.svg',
                                              size: 90,
                                              glowColor: Colors.white,
                                              borderColor: Colors.white,
                                              borderWidth: 3.0,
                                            ),
                                            Text(
                                              user.name ?? '',
                                              style: kHeadTitleSB.copyWith(
                                                  color: kWhite),
                                            ),
                                            const SizedBox(height: 5),
                                            Column(
                                              children: [
                                                if (designations.isNotEmpty ||
                                                    companyNames.isNotEmpty)
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (designations
                                                          .isNotEmpty)
                                                        Text(
                                                          designations
                                                              .join(' | '),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      if (companyNames
                                                          .isNotEmpty)
                                                        Text(
                                                          companyNames
                                                              .join(' | '),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                if (levelData['chapterName'] !=
                                                    'undefined')
                                                  const SizedBox(height: 10),
                                                if (levelData['chapterName'] !=
                                                    'undefined')
                                                  Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                      Text(
                                                        '${levelData['stateName']} / ',
                                                        style: const TextStyle(
                                                            color: kWhite,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '${levelData['zoneName']} / ',
                                                        style: const TextStyle(
                                                            color: kWhite,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '${levelData['districtName']} / ',
                                                        style: const TextStyle(
                                                            color: kWhite,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '${levelData['chapterName']} ',
                                                        style: const TextStyle(
                                                            color: kWhite,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Joined Date: $joinedDate',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              234, 226, 226))),
                                                  child: IntrinsicWidth(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Image.asset(
                                                              scale: 20,
                                                              'assets/png/Logo.png'),
                                                        ),
                                                        const SizedBox(
                                                            width:
                                                                10), // Add spacing between elements
                                                        Text(
                                                            'Member ID: ${user.memberId}',
                                                            style: kSmallerTitleB
                                                                .copyWith(
                                                                    color: kPrimaryColor
                                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 1,
                                                      child: CustomPaint(
                                                        size: const Size(
                                                            double.infinity, 1),
                                                        painter:
                                                            DottedLinePainter(),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 10,
                                                        left: 15,
                                                        right: 15,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          ContactRow(
                                                              icon: Icons.phone,
                                                              text:
                                                                  user.phone ??
                                                                      ''),
                                                          if (user.email !=
                                                                  '' &&
                                                              user.email !=
                                                                  null)
                                                            const SizedBox(
                                                                height: 10),
                                                          if (user.email !=
                                                                  '' &&
                                                              user.email !=
                                                                  null)
                                                            ContactRow(
                                                                icon:
                                                                    Icons.email,
                                                                text:
                                                                    user.email ??
                                                                        ''),
                                                          if (user.address !=
                                                                  '' &&
                                                              user.address !=
                                                                  null)
                                                            const SizedBox(
                                                                height: 10),
                                                          if (user.address !=
                                                                  '' &&
                                                              user.address !=
                                                                  null)
                                                            ContactRow(
                                                                icon: Icons
                                                                    .location_on,
                                                                text:
                                                                    user.address ??
                                                                        ''),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // captureAndShareOrDownloadWidgetScreenshot(context);
                        },
                        child: SvgPicture.asset(
                            color: kPrimaryColor,
                            'assets/svg/icons/shareButton.svg'),
                        // child: Container(
                        //   width: 90,
                        //   height: 90,
                        //   decoration: BoxDecoration(
                        //     color: kPrimaryColor,
                        //     borderRadius: BorderRadius.circular(
                        //         50), // Apply circular border to the outer container
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(50),
                        //         color: kPrimaryColor,
                        //       ),
                        //       child: Icon(
                        //         Icons.share,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                          onTap: () {
                            navigationService.pushNamed('Card',
                                arguments: user);
                          },
                          child: SvgPicture.asset(
                            'assets/svg/icons/qrButton.svg',
                            color: kPrimaryColor,
                          )
                          // Container(
                          //   width: 90,
                          //   height: 90,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(
                          //         50), // Apply circular border to the outer container
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(4.0),
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(50),
                          //         color: Colors.white,
                          //       ),
                          //       child: Icon(
                          //         Icons.qr_code,
                          //         color: Colors.grey,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          )
                    ],
                  ),
                  SizedBox(
                    height: 140,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
