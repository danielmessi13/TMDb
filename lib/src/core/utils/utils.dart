import 'package:tmdb_app/src/core/models/genre_model.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

MovieModel getMovieWithComputedData(movie, List<GenreModel> listGenres) {
  MovieModel currentMovie = setGenres(movie, listGenres);
  setDate(currentMovie);
  return currentMovie;
}

MovieModel setGenres(movie, List<GenreModel> listGenres) {
  var currentMovie = MovieModel.fromJson(movie);

  if (currentMovie.genreIds.length == 0) {
    currentMovie.genres = "No genre defined";
  } else {
    for (var i = 0; i < currentMovie.genreIds.length; i++) {
      var genre = listGenres?.firstWhere(
        (genre) => genre?.id == currentMovie?.genreIds[i],
      );

      currentMovie.genres += genre?.name != null
          ? genre.name + "${currentMovie.genreIds.length - 1 != i ? ', ' : ''}"
          : "";
    }
  }

  return currentMovie;
}

void setDate(MovieModel currentMovie) {
  if (currentMovie.releaseDate != null &&
      currentMovie.releaseDate.trim().isNotEmpty &&
      currentMovie.releaseDate.trim() != "") {
    List<String> listDate =
        currentMovie?.releaseDate?.split("-") ?? ["00", "00", "00"];
    currentMovie.releaseDate =
        "${listDate[2] + '/' + listDate[1] + '/' + listDate[0]}";
  } else {
    currentMovie.releaseDate = "No release date";
  }
}
