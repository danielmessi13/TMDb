import 'package:flutter/material.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.050;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF04774D),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w154/${movie.posterPath}",
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie?.originalTitle ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: Color(0xFF04774D),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xFF04774D),
                ),
                SizedBox(height: 20),
                Text(
                  movie?.genres ?? "",
                  style: TextStyle(
                    fontSize: fontSize * 0.8,
                  ),
                ),
                Text(
                  movie?.releaseDate ?? "",
                  style: TextStyle(
                    fontSize: fontSize * 0.8,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
