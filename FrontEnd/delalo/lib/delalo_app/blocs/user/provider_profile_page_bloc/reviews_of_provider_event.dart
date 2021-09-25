part of 'reviews_of_provider_bloc.dart';

@immutable
abstract class ReviewsOfProviderEvent {}

class LoadReviewsOfProvider extends ReviewsOfProviderEvent {
  final String providerId;

  LoadReviewsOfProvider({required this.providerId});
}
