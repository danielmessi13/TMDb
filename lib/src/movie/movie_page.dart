import 'package:flutter/material.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

class MoviePage extends StatelessWidget {
  final MovieModel movie;

  const MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.050;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: Colors.transparent,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://image.tmdb.org/t/p/w780/${movie.backdropPath}",
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Hero(
                        tag: movie.id,
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
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w154/${movie.posterPath}",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 215,
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
                    ),
                  ],
                ),
                OverviewMovie(overview: movie?.overview ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewMovie extends StatelessWidget {
  const OverviewMovie({
    Key key,
    @required this.overview,
  }) : super(key: key);

  final String overview;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.050;

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.new_releases,
                    color: Theme.of(context).primaryColor,
                    size: fontSize,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Overview",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      letterSpacing: 1.5,
                      color: Color(0xFF04774D),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                color: Color(0xFF04774D),
                endIndent: 10,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Text(
            overview,
            style: TextStyle(
              fontSize: fontSize * 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
