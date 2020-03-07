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
  final _scrollThreshold = 300.0;
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _scrollController.addListener(listenerController);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  listenerController() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (_homeBloc.state is! HomeLoading &&
        maxScroll - currentScroll <= _scrollThreshold) {
      _homeBloc.add(HomeStart());
    }
  }

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
          } else if (state is HomeSuccess || state is HomeLoading) {
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: _homeBloc.listMovies.length,
              itemBuilder: (_, index) {
               
                return Column(
                  children: <Widget>[
                    MovieCard(movie: _homeBloc.listMovies[index]),
                    state is HomeLoading &&
                            _homeBloc.listMovies.length - 1 == index
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Container(),
                  ],
                );
              },
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
