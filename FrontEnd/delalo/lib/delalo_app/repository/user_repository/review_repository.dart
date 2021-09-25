import 'package:delalo/delalo_app/data_provider/user_data/review_data.dart';
import 'package:delalo/delalo_app/models/review.dart';

class ReviewRepository {
  final ReviewDataProvider reviewDataProvider;
  ReviewRepository({required this.reviewDataProvider});

  Future<Review> addReview(int rating, String comment, String order_id) async {
    return await reviewDataProvider.addReview(rating, comment, order_id);
  }

  Future<List<Review>> getReview() async {
    return await reviewDataProvider.getReview();
  }

  Future<void> deleteReview(String id) async {
    await reviewDataProvider.deleteReview(id);
  }

  Future<void> updateReview(Review review) async {
    await reviewDataProvider.updateReview(review);
  }
}
