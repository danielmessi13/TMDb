part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeStart extends HomeEvent {}

class HomeSearch extends HomeEvent {
  final String query;

  HomeSearch({@required this.query});
}

class HomeClear extends HomeEvent {}

class HomeSearchPagination extends HomeEvent {}
