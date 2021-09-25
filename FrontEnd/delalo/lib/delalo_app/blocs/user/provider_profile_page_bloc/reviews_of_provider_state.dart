part of 'reviews_of_provider_bloc.dart';

@immutable
abstract class ReveiwsOfProviderState {}

class ReviewsOfProviderInitial extends ReveiwsOfProviderState {}

class ReviewsOfProviderInfoLoading extends ReveiwsOfProviderState {}

class ReviewsOfProviderLoadSuccess extends ReveiwsOfProviderState {
  final orderDetailsOfProvider;

  ReviewsOfProviderLoadSuccess(this.orderDetailsOfProvider);
}

class ReviewsOfProviderLoadFailure extends ReveiwsOfProviderState {
  final error;

  ReviewsOfProviderLoadFailure({required this.error});
}
