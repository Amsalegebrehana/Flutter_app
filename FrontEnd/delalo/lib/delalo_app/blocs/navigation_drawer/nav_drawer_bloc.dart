import 'package:bloc/bloc.dart';
import 'nav_drawer_event.dart';
import 'nav_drawer_state.dart';

class NavDrawerBloc extends Bloc<NavDrawerEvent,NavDrawerState>{
  NavDrawerBloc() : super (Home());

  @override
  Stream<NavDrawerState> mapEventToState(NavDrawerEvent event,)async* {
    if(event is HomePageEvent){
      yield Home();
    }else if (event is AccountPageEvent){
      yield Account();
    }
    else if (event is OrdersPageEvent){
      yield Orders();
    }
    else if(event is JobsPageEvent){
      yield Jobs();
    }
    else if(event is LogoutPageEvent){
      yield LoggedOut();
    }
  }

}