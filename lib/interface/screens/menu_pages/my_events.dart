import 'package:dubaiprojectxyvin/interface/Data/models/event_model.dart';
import 'package:dubaiprojectxyvin/interface/compon/common_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
 final List<Event> registeredEvents = [
  Event(
    id: "event_001",
    eventName: "Flutter Workshop",
    description: "A hands-on workshop to build apps with Flutter.",
    type: "Workshop",
    image: "https://example.com/images/flutter_event.jpg",
    startDate: DateTime.now().add(Duration(days: 2)),
    startTime: DateTime.now().add(Duration(days: 2, hours: 10)),
    endDate: DateTime.now().add(Duration(days: 2)),
    endTime: DateTime.now().add(Duration(days: 2, hours: 12)),
    eventDate: DateTime.now().add(Duration(days: 2)),
    platform: "Zoom",
    link: "https://zoom.us/j/123456789",
    venue: null,
    organiserName: "Tech Club",
    coordinator: ["John Doe", "Jane Smith"],
    speakers: [
      Speaker(
        name: "Alice Johnson",
        designation: "Flutter Developer",
        role: "Keynote Speaker",
        image: "https://example.com/images/speaker1.jpg",
      ),
      Speaker(
        name: "Bob Smith",
        designation: "Google Developer Expert",
        role: "Trainer",
        image: "https://example.com/images/speaker2.jpg",
      ),
    ],
    status: "upcoming",
    rsvp: ["user_101", "user_102"],
    attended: [],
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    updatedAt: DateTime.now(),
    limit: 100,
  ),
  Event(
    id: "event_002",
    eventName: "AI Conference",
    description: "Exploring the future of artificial intelligence.",
    type: "Conference",
    image: "https://example.com/images/ai_event.jpg",
    startDate: DateTime.now().add(Duration(days: 10)),
    startTime: DateTime.now().add(Duration(days: 10, hours: 9)),
    endDate: DateTime.now().add(Duration(days: 10)),
    endTime: DateTime.now().add(Duration(days: 10, hours: 17)),
    eventDate: DateTime.now().add(Duration(days: 10)),
    platform: "Offline",
    link: null,
    venue: "Tech Auditorium, Downtown",
    organiserName: "AI Society",
    coordinator: ["Emily Watson"],
    speakers: [
      Speaker(
        name: "Dr. Mark Lee",
        designation: "AI Researcher",
        role: "Speaker",
        image: "https://example.com/images/speaker3.jpg",
      ),
    ],
    status: "upcoming",
    rsvp: ["user_105"],
    attended: [],
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    updatedAt: DateTime.now(),
    limit: 300,
  ),
  Event(
    id: "event_003",
    eventName: "Past Design Meetup",
    description: "A meetup for creative designers.",
    type: "Meetup",
    image: "https://example.com/images/design_event.jpg",
    startDate: DateTime.now().subtract(Duration(days: 5)),
    startTime: DateTime.now().subtract(Duration(days: 5, hours: 10)),
    endDate: DateTime.now().subtract(Duration(days: 5)),
    endTime: DateTime.now().subtract(Duration(days: 5, hours: 12)),
    eventDate: DateTime.now().subtract(Duration(days: 5)),
    platform: "Google Meet",
    link: "https://meet.google.com/xyz-abc-pqr",
    venue: null,
    organiserName: "Design Hub",
    coordinator: ["Sam Lee"],
    speakers: [],
    status: "completed",
    rsvp: ["user_110", "user_111"],
    attended: ["user_110"],
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    updatedAt: DateTime.now().subtract(Duration(days: 5)),
    limit: 50,
  ),
];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "My Events",
              style: TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: 
               ListView.builder(
                itemCount: registeredEvents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: eventCard(
                        context: context, event: registeredEvents[index]),
                  );
                },
              )
           
        );
      },
    );
  }

  Widget eventCard({required BuildContext context, required Event event}) {
    DateTime dateTime = DateTime.parse(event.eventDate.toString()).toLocal();

    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    // If the image is fully loaded, show the image
                    return child;
                  }
                  // While the image is loading, show shimmer effect
                  return Container(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.network('https://placehold.co/600x400');
                },
                event.image ?? 'https://via.placeholder.com/400x200',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  color: const Color(0xFFA9F3C7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(event.status!,
                      style: TextStyle(color: Color(0xFF0F7036), fontSize: 14)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.type!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3F0A9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 20, color: Color(0xFF700F0F)),
                          const SizedBox(width: 5),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF700F0F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      event.type!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        event.description ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (event.link != null && event.link != '')
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        launchUrl(Uri.parse(event.link ?? ''));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              4), // Adjust the value to make the edge less circular
                        ),
                        minimumSize: const Size(
                            150, 40), // Adjust the width of the button
                      ),
                      child: const Text('JOIN',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
