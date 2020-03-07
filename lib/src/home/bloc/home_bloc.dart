import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

import '../home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _homeService = HomeService();
  int _nextPage = 1;

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
      yield HomeInitial();
      try {
        final listGenres = await _homeService.getGenres();
        final listMovies = await _homeService.getMovies(_nextPage, listGenres);

       
        yield HomeSuccess(listMovies: listMovies);
      } catch (e) {
        yield HomeFailure();
      }
    }
  }
}
