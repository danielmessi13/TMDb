import 'package:flutter/material.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';
import 'package:tmdb_app/src/movie/movie_page.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.050;
    return Hero(
      tag: movie.id,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoviePage(
                  movie: movie,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 220,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF04774D),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w342/${movie.posterPath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movie?.originalTitle ?? "",
                          overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          flex: 2,
                          child: Text(
                            movie?.genres ?? "",
                            style: TextStyle(
                              fontSize: fontSize * 0.8,
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
