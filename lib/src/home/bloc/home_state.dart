part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieModel> listMovies;

  HomeSuccess({@required this.listMovies});
}

class HomeFailure extends HomeState {}
