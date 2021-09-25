import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/repository/user_repository/provider_repository.dart';
import 'package:delalo/delalo_app/blocs/user/provider_bloc/provider_event.dart';
import 'package:delalo/delalo_app/blocs/user/provider_bloc/provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final ProviderRepository providerRepository;

  ProviderBloc({required this.providerRepository})
      : assert(ProviderRepository != null),
        super(ProviderLoading());
  @override
  Stream<ProviderState> mapEventToState(ProviderEvent event) async* {
    if (event is ProviderLoad) {
      yield ProviderLoading();
      try {
        final providers = await providerRepository.getProviders();
        yield ProviderLoadSuccess(providers);
      } catch (_) {
        yield ProviderOperationFailure();
      }
    }

    // if (event is ProviderUpdate) {
    //   try {
    //     await providerRepository.updateProvider(event.ProviderOnly);
    //     final providers = await providerRepository.getProviders();
    //     yield ProviderLoadSuccess(providers);
    //   } catch (_) {
    //     yield ProviderOperationFailure();
    //   }
    // }

    // if (event is ProviderDelete) {
    //   try {
    //     await providerRepository.deleteProvider(event.Provider);
    //     final providers = await providerRepository.getProviders();
    //     yield ProviderLoadSuccess(providers);
    //   } catch (_) {
    //     yield ProviderOperationFailure();
    //   }
    // }
  }
}
