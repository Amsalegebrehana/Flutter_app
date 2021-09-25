import 'package:delalo/delalo_app/blocs/admin_bloc/provider_bloc/provider_event.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/provider_bloc/provider_state.dart';
import 'package:delalo/delalo_app/repository/admin_repository/admin_provider_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvidersBloc extends Bloc<ProviderEvent, ProvidersState> {
  final AdminProviderRepository providersRepository;

  ProvidersBloc({required this.providersRepository}) : super(ProviderLoading());

  @override
  Stream<ProvidersState> mapEventToState(ProviderEvent event) async* {
    // TO DO: implement mapEventToState
    if (event is LoadAllProviders) {
      yield ProviderLoading();
      try {
        final providers = await providersRepository.getProvidersFromProvider();
        yield ProviderLoaded(providers);
      } catch (_) {
        yield ProvidersOperationsFailed();
      }
    }
  }
}
