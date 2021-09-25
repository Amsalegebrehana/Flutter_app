import 'package:bloc/bloc.dart';
import 'package:delalo/delalo_app/models/category.dart';
import 'package:delalo/delalo_app/repository/user_repository/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';


class SearchBloc extends Bloc<SearchEvent,SearchState>{
  SearchCategoryRepository searchRepository;
  SearchBloc({required this.searchRepository}): super(SearchUninitialized());

  SearchState get initialState => SearchUninitialized();
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{
    if(event is Search){
      yield SearchUninitialized();

      try{
        List<Category> categories = await searchRepository.getCategories(event.query);
        yield SearchLoaded(categories: categories);
        
      }catch(e){
          print(e.toString());
          yield SearchError();
      }

    }
  }
}