import 'package:bloc/bloc.dart';
import 'package:delalo/delalo_app/repository/user_repository/single_provider_page_repository.dart';
import 'package:flutter/material.dart';

part 'reviews_of_provider_event.dart';
part 'reviews_of_provider_state.dart';

class ReviewsOfProviderBloc
    extends Bloc<ReviewsOfProviderEvent, ReveiwsOfProviderState> {
  final ProviderProfileRepository providerProfileRepository;
  ReviewsOfProviderBloc({required this.providerProfileRepository})
      : super(ReviewsOfProviderInitial());

  @override
  Stream<ReveiwsOfProviderState> mapEventToState(
      ReviewsOfProviderEvent event) async* {
    if (event is LoadReviewsOfProvider) {
      yield ReviewsOfProviderInfoLoading();
      await Future.delayed(Duration(milliseconds: 500));
      try {
        final orders_with_reviews_loaded = await providerProfileRepository
            .getReviewsOfProvider(event.providerId);
        yield ReviewsOfProviderLoadSuccess(orders_with_reviews_loaded);
      } catch (e) {
        yield ReviewsOfProviderLoadFailure(error: e.toString());
      }
    }
  }
}
