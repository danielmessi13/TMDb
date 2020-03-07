import 'package:tmdb_app/src/core/api/api_info.dart';
import 'package:tmdb_app/src/core/models/genre_model.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

class HomeService {
  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await dio.get("genre/movie/list");

      List<GenreModel> listGenres = List<GenreModel>.from(
        response.data['genres'].map(
          (genre) => GenreModel.fromJson(genre),
        ),
      );

      return listGenres;
    } catch (e) {
      throw e;
    }
  }

  Future<List<MovieModel>> getMovies(
      int page, List<GenreModel> listGenres) async {
    try {
      final response = await dio.get(
        "movie/upcoming",
        queryParameters: {"page": page},
      );

      List<MovieModel> listMovies = List<MovieModel>.from(
        response.data['results'].map(
          (movie) {
            var currentMovie = MovieModel.fromJson(movie);

            for (var i = 0; i < currentMovie.genreIds.length; i++) {
              var genre = listGenres.firstWhere(
                (genre) => genre.id == currentMovie.genreIds[i],
              );
              
              currentMovie.genres += genre.name +
                  "${currentMovie.genreIds.length - 1 != i ? ', ' : ''}";
            }

            return currentMovie;
          },
        ),
      );

      return listMovies;
    } catch (e) {
      throw e;
    }
  }
}
