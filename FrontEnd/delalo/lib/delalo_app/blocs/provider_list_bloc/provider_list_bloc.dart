import 'package:delalo/delalo_app/blocs/provider_list_bloc/provider_list_event.dart';
import 'package:delalo/delalo_app/blocs/provider_list_bloc/provider_list_state.dart';
import 'package:delalo/delalo_app/repository/user_repository/provider_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProviderListBloc extends Bloc<ProviderListEvent,ProviderListState>{
  final ProviderListRepository providerListRepository;

  ProviderListBloc({required this.providerListRepository}) : super(ProviderListLoading());

  @override
  Stream<ProviderListState> mapEventToState(ProviderListEvent event) async* {
    if(event is ProviderListLoad){
      yield ProviderListLoading();

        try{
          final providers= await providerListRepository.getProviderList(event.category);
          yield ProviderListLoadSuccess(providers);
        }
        catch(_){
          yield ProviderListLoadFail();
        }

    }
  }

}