import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  BottomNavigationState([List props = const []]) : super();

  get posIndex => 0;
}

class ShowHomePage extends BottomNavigationState {
  final posIndex=0;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShowCategoryPage extends BottomNavigationState {
  final posIndex=1;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShowOrdersPage extends BottomNavigationState {
final posIndex=2;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShowJobsPage extends BottomNavigationState{
  final posIndex=3;
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ShowAccountPage extends BottomNavigationState{
  final posIndex=4;
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}