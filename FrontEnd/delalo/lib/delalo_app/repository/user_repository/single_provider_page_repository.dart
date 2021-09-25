import 'package:delalo/delalo_app/data_provider/user_data/single_provider_page_data.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/models/orderDetailsReview.dart';
import 'package:delalo/delalo_app/models/provider_isHired.dart';

class ProviderProfileRepository {
  final ProviderProfileDataProvider dataProvider;

  ProviderProfileRepository({required this.dataProvider});

  Future<ProviderIsHired> getProvider(
      String providerid, String seekerId) async {
    return await dataProvider.getProvider(providerid, seekerId);
  }

  Future<List<OrderDetailsReview>> getReviewsOfProvider(String id) async {
    return await dataProvider.getReviewsOfProvider(id);
  }

  Future<void> createOrder(String providerId) async {
    await dataProvider.createOrder(providerId);
  }
}
