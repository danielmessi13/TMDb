import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/src/core/widgets/error_widget.dart';
import 'package:tmdb_app/src/home/bloc/home_bloc.dart';

import 'widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Upcoming Movies"),
      ),
      body: BlocBuilder(
        bloc: _homeBloc,
        builder: (_, state) {
          if (state is HomeInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: state.listMovies.length,
              itemBuilder: (_, index) =>
                  MovieCard(movie: state.listMovies[index]),
            );
          } else if (state is HomeFailure) {
            return Stack(
              children: <Widget>[
                FailureWidget(
                  message:
                      "Unable to list movies, click the icon below to try again",
                ),
                Center(
                  child: IconButton(
                    iconSize: MediaQuery.of(context).size.width * 0.1,
                    icon: Icon(Icons.replay),
                    onPressed: () {
                      _homeBloc.add(HomeStart());
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
