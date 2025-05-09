import 'package:dubaiprojectxyvin/Data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shimmer/shimmer.dart';

Widget eventWidget({
  bool withImage = true,
  required BuildContext context,
  required Event event,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Transform.translate(
      offset: const Offset(0, 6),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (withImage)
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    width: MediaQuery.sizeOf(context).width * .95,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        event.image ?? '',
                        fit: BoxFit.cover,
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
                          if (loadingProgress == null) return child;
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
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: event.status == 'completed'
                            ? const Color(0xFF434343)
                            : event.status == 'live'
                                ? const Color(0xFF2D8D00)
                                : const Color(0xFF596AFF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          if (event.status == 'completed')
                            SvgPicture.asset(
                              'assets/svg/icons/completed.svg',
                              color: Colors.white,
                            ),
                          if (event.status == 'live')
                            SvgPicture.asset(
                              'assets/svg/icons/live.svg',
                              color: Colors.white,
                            ),
                          if (event.status == 'upcoming')
                            const Icon(Icons.access_time, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            event.status?.toUpperCase() ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
