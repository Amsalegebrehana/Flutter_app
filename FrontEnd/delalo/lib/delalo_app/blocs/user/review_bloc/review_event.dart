import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class AddReview extends ReviewEvent {
  final String order_id;
  final int rating;
  final String comment;
  const AddReview(this.rating, this.comment, this.order_id);

  @override
  List<Object> get props => [];
}

class ReviewLoad extends ReviewEvent {
  @override
  List<Object> get props => [];
}
