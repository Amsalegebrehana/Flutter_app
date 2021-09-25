import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc({required this.reviewRepository})
      : assert(reviewRepository != null),
        super(ReviewLoading());

  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async* {
    if (event is AddReview) {
      try {
        await reviewRepository.addReview(
            event.rating, event.comment, event.order_id);
        yield AddReviewSuccess();
      } catch (_) {
        yield AddReviewFailure();
      }
    }
  }
}
