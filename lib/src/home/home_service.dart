import 'package:tmdb_app/src/core/api/api_info.dart';
import 'package:tmdb_app/src/core/models/genre_model.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';
import 'package:tmdb_app/src/core/utils/utils.dart';

class HomeService {
  Future<Map<String, dynamic>> searchMovie(
      int nextPage, String query, List<GenreModel> listGenres) async {
    try {
      final response = await dio.get(
        "search/movie",
        queryParameters: {
          "query": query,
          "page": nextPage,
        },
      );

      List<MovieModel> listMovies = List<MovieModel>.from(
        response.data['results'].map(
          (movie) => getMovieWithComputedData(movie, listGenres),
        ),
      );

      return {
        "list_movies": listMovies,
        "last_page": response.data['total_pages']
      };
    } catch (e) {
      throw e;
    }
  }

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

  Future<Map<String, dynamic>> getMovies(
      int page, List<GenreModel> listGenres) async {
    try {
      final response = await dio.get(
        "movie/upcoming",
        queryParameters: {"page": page},
      );

      List<MovieModel> listMovies = List<MovieModel>.from(
        response.data['results'].map(
          (movie) => getMovieWithComputedData(movie, listGenres),
        ),
      );

      return {
        "list_movies": listMovies,
        "last_page": response.data['total_pages']
      };
    } catch (e) {
      throw e;
    }
  }
}
