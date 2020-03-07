import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_app/src/core/models/genre_model.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

import '../home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _homeService = HomeService();
  int _nextPage = 1;
  int _lastPage;
  List<MovieModel> listMovies = [];
  List<GenreModel> listGenres = [];

  @override
  HomeState get initialState => HomeInitial();

  HomeBloc() {
    this.add(HomeStart());
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeStart) {
      if (_nextPage == 1) {
        yield HomeInitial();
      } else if (_lastPage == null || _nextPage < _lastPage) {
        yield HomeLoading();
      } else {
        yield HomeSuccess();
      }
      try {
        if (_nextPage == 1) {
          listGenres = await _homeService.getGenres();
        }
        final json = await _homeService.getMovies(_nextPage, listGenres);
        listMovies.addAll(json['list_movies']);
        _nextPage++;
        _lastPage = json['last_page'];
        yield HomeSuccess();
      } catch (e) {
        yield HomeFailure();
      }
    }
  }
}
