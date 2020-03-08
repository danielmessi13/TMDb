import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_app/src/core/models/genre_model.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';
import 'package:rxdart/rxdart.dart';

import '../home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _homeService = HomeService();
  int _nextPage = 1;
  int _lastPage;

  int _nextSearchPage;
  int _lastSearchPage;

  List<MovieModel> listMovies = [];
  List<MovieModel> listSearchMovies = [];
  List<GenreModel> listGenres = [];

  String query;

  @override
  HomeState get initialState => HomeInitial();

  HomeBloc() {
    this.add(HomeStart());
  }

  @override
  Stream<HomeState> transformEvents(
    Stream<HomeEvent> events,
    Stream<HomeState> Function(HomeEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! HomeClear && event is! HomeSearch);
    });

    final debounceStream = events.where((event) {
      return (event is HomeClear || event is HomeSearch);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeStart) {
      bool valid = true;
      if (_nextPage == 1) {
        yield HomeInitial();
      } else if (_lastPage == null || _nextPage < _lastPage) {
        yield HomeLoading();
      } else {
        valid = false;
        yield HomeSuccess();
      }
      try {
        if (_nextPage == 1) {
          listGenres = await _homeService.getGenres();
        }

        if (valid) {
          final json = await _homeService.getMovies(_nextPage, listGenres);
          listMovies.addAll(json['list_movies']);
          _nextPage++;
          _lastPage = json['last_page'];
        }

        yield HomeSuccess();
      } catch (e) {
        yield HomeFailure();
      }
    } else if (event is HomeSearch) {
      yield HomeInitial();
      query = event.query;
      _nextSearchPage = 1;
      _lastSearchPage = null;

      try {
        final json = await _homeService.searchMovie(
          _nextSearchPage,
          query,
          listGenres,
        );

        listSearchMovies = json['list_movies'];
        _lastSearchPage = json['last_page'];

        yield HomeSearchSuccess();
      } catch (e) {
        yield HomeFailure();
      }
    } else if (event is HomeClear) {
      listSearchMovies = [];
      _nextSearchPage = 1;
      _lastSearchPage = null;
      yield HomeSuccess();
    } else if (event is HomeSearchPagination) {
      if (_lastSearchPage == null || _nextSearchPage < _lastSearchPage) {
        yield HomeLoading();
        _nextSearchPage++;
      } else {
        yield HomeSearchSuccess();
        return;
      }

      try {
        final json = await _homeService.searchMovie(
          _nextSearchPage,
          query,
          listGenres,
        );

        listSearchMovies.addAll(json['list_movies']);
        yield HomeSearchSuccess();
      } catch (e) {
        yield HomeFailure();
      }
    }
  }
}
