import 'package:dubaiprojectxyvin/Data/models/review_model.dart';
import 'package:dubaiprojectxyvin/interface/components/custom_widgets/review_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsState extends StateNotifier<int> {
  ReviewsState() : super(1);

  void showMoreReviews(int totalReviews) {
    state = (state + 2).clamp(0, totalReviews);
  }
}

final reviewsProvider = StateNotifierProvider<ReviewsState, int>((ref) {
  return ReviewsState();
});

class MyReviewsPage extends ConsumerStatefulWidget {
  const MyReviewsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends ConsumerState<MyReviewsPage> {
  @override
  void initState() {
    super.initState();
    // Move invalidate call to initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.invalidate(fetchReviewsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final reviewsToShow = ref.watch(reviewsProvider);
        final List<ReviewModel> reviews = [
  ReviewModel(
    id: "review_001",
    toUser: "user_123",
    reviewer: Reviewer(
      id: "rev_001",
      name: "Alice Johnson",
      image: "https://example.com/images/alice.jpg",
    ),
    rating: 5,
    comment: "Excellent service and communication!",
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    updatedAt: DateTime.now().subtract(Duration(days: 1)),
    version: 1,
  ),
  ReviewModel(
    id: "review_002",
    toUser: "user_123",
    reviewer: Reviewer(
      id: "rev_002",
      name: "Bob Smith",
      image: "https://example.com/images/bob.jpg",
    ),
    rating: 4,
    comment: "Very good experience, would recommend.",
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    updatedAt: DateTime.now().subtract(Duration(days: 2)),
    version: 1,
  ),
  ReviewModel(
    id: "review_003",
    toUser: "user_456",
    reviewer: Reviewer(
      id: "rev_003",
      name: "Catherine Green",
      image: "https://example.com/images/catherine.jpg",
    ),
    rating: 3,
    comment: "Satisfactory, but could be better.",
    createdAt: DateTime.now().subtract(Duration(days: 15)),
    updatedAt: DateTime.now().subtract(Duration(days: 5)),
    version: 1,
  ),
];

        // final asyncReviews = ref.watch(fetchReviewsProvider(userId: id));
               final ratingDistribution = getRatingDistribution(reviews);
                final averageRating = getAverageRating(reviews);
                final totalReviews = reviews.length;

        if (reviewsToShow == 0) {
          return const Center(
            child: Text('No Reviews'),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'My Reviews',
                style: TextStyle(fontSize: 17),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
            ),
            body: 
         
                 SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 1.0,
                        color: Colors.grey[300], // Divider color
                      ),
                      if (totalReviews != 0)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ReviewBarChart(
                            reviews: reviews,
                          ),
                        ),
                      if (reviews.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: reviewsToShow,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReviewsCard(
                                  review: reviews[index],
                                  ratingDistribution: ratingDistribution,
                                  averageRating: averageRating,
                                  totalReviews: totalReviews,
                                ),
                              );
                            },
                          ),
                        ),
                      if (reviewsToShow < reviews.length)
                        TextButton(
                          onPressed: () {
                            ref
                                .read(reviewsProvider.notifier)
                                .showMoreReviews(reviews.length);
                          },
                          child: Text('View More'),
                        ),
                    ],
                  ),
                )
             
          );
        }
      },
    );
  }
}
