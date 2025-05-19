import 'package:dubaiprojectxyvin/Data/services/api_routes/review_api/review_api.dart';
import 'package:dubaiprojectxyvin/Data/services/api_routes/user_api/user_data/edit_user.dart';
import 'package:dubaiprojectxyvin/Data/utils/common_color.dart';
import 'package:dubaiprojectxyvin/interface/components/buttons/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ShowWriteReviewSheet extends StatefulWidget {
  final String userId;
  ShowWriteReviewSheet({
    super.key,
    required this.userId,
  });

  @override
  State<ShowWriteReviewSheet> createState() => _ShowWriteReviewSheetState();
}

class _ShowWriteReviewSheetState extends State<ShowWriteReviewSheet> {
  TextEditingController feedbackController = TextEditingController();
  int selectedRating = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'Write Review?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  Icons.star,
                  color: index < selectedRating ? Colors.amber : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    selectedRating = index + 1;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: feedbackController,
            decoration: const InputDecoration(
              hintText: 'Leave Your Feedback here',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: GradientButton(
                      labelColor: kPrimaryColor,
                      buttonSideColor: kPrimaryColor,
                      solidColor: kWhite,
                      title: 'Cancel',
                      onPressed: () {})),
              const SizedBox(width: 10),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return GradientButton(
                        title: 'Submit',
                        onPressed: () async {
                          await postReview(
                                  widget.userId,
                                  feedbackController.text,
                                  selectedRating,
                                  context)
                              .then(
                            (value) {
                              ref.invalidate(fetchReviewsProvider);
                            },
                          );
                          Navigator.of(context).pop();
                        });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
