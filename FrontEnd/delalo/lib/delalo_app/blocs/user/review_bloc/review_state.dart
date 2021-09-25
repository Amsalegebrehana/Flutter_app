import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewLoading extends ReviewState {}

class AddReviewSuccess extends ReviewState {
  AddReviewSuccess();

  @override
  List<Object> get props => [];
}

class AddReviewFailure extends ReviewState {
  AddReviewFailure();

  @override
  List<Object> get props => [];
}
