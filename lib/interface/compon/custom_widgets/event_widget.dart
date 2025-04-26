import 'package:dubaiprojectxyvin/interface/Data/routes/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';

Widget eventWidget({
  bool withImage = true,
  required BuildContext context,
  required Event event,
}) {
  String formattedDate = '';

  if (event.eventDate != null) {
    try {
      DateTime date = DateTime.parse(event.eventDate.toString()).toLocal();
      formattedDate = DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      formattedDate = 'Invalid date';
    }
  } else {
    formattedDate = 'TBA'; // "To Be Announced" or any other placeholder text
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Transform.translate(
      offset: const Offset(0, 6),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (withImage) ...[
              Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    width: MediaQuery.sizeOf(context).width * .95,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(event.image ?? '', fit: BoxFit.cover,
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
                      }, loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  );
                      }),
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
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                            ),
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
            ],
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          event.eventName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 13, color: Color(0xFF700F0F)),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF700F0F),
                            ),
                          ),
                        ],
                      ),
                    ],
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
