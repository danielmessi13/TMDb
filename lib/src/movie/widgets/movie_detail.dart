import 'package:flutter/material.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.050;

    return Container(
      height: 240,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Hero(
                tag: movie.id,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF04774D),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w342/${movie.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
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
                  endIndent: 10,
                ),
                Text(
                  movie?.genres ?? "",
                  style: TextStyle(
                    fontSize: fontSize * 0.8,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: fontSize,
                      ),
                      SizedBox(width: 10),
                      Text(
                        movie?.releaseDate ?? "",
                        style: TextStyle(
                          fontSize: fontSize * 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
