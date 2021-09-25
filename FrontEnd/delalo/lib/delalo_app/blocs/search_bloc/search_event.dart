abstract class SearchEvent{}

class Search extends SearchEvent{
  String query;
  Search({required this.query});

  List<Object> get props => [];
}