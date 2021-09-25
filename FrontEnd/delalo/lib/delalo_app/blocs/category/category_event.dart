import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoriesLoad extends CategoryEvent {
  const CategoriesLoad();

  @override
  List<Object> get props => [];
}

class CategoryLoad extends CategoryEvent {
  final String id;
  const CategoryLoad(this.id);

  @override
  List<Object> get props => [];
}