import 'dart:async';

import 'package:bloc/bloc.dart';
import 'bottomNavigationEvent.dart';
import 'bottomNavigationState.dart';


class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {

  BottomNavigationBloc(int currentIndex) : super(ShowHomePage());

  @override
  Stream<BottomNavigationState> mapEventToState(BottomNavigationEvent event) async* {
      
      if(event is BottomHomePageEvent){
        yield ShowHomePage();
      }
     else if(event is BottomCategoryPageEvent){
       print('show category called');
       yield ShowCategoryPage();
     }
     else if(event is BottomOrdersPageEvent){
       yield ShowOrdersPage();
     }
     else if(event is BottomJobsPageEvent){
       yield ShowJobsPage();
     }
     else if(event is BottomAccountPageEvent){
       yield ShowAccountPage();
     }
  }
}
  