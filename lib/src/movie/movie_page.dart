import 'package:flutter/material.dart';
import 'package:tmdb_app/src/core/models/movie_model.dart';

import 'widgets/movie_detail.dart';
import 'widgets/overview_movie.dart';

class MoviePage extends StatelessWidget {
  final MovieModel movie;

  const MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Image.network(
                  "https://image.tmdb.org/t/p/w780/${movie.backdropPath}",
                  fit: BoxFit.cover,
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
                MovieDetail(movie: movie),
                OverviewMovie(overview: movie?.overview ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
