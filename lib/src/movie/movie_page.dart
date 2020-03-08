import 'package:cached_network_image/cached_network_image.dart';
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
              background: ShaderMask(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://image.tmdb.org/t/p/w780/${movie.backdropPath}",
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                shaderCallback: (Rect bounds) {
                  return LinearGradient(colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.5),
                  ]).createShader(bounds);
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 15),
                Container(
                  height: 250,
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
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w342/${movie.posterPath}",
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Center(child: Icon(Icons.error)),
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
