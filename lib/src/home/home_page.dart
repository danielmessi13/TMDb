import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/src/core/widgets/failure_widget.dart';
import 'package:tmdb_app/src/home/bloc/home_bloc.dart';

import 'widgets/movie_card.dart';
import 'widgets/text_field_custom.dart';

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
      if (_homeBloc.state is HomeSearchSuccess) {
        _homeBloc.add(HomeSearchPagination());
      } else if (_homeBloc.state is HomeSuccess) {
        _homeBloc.add(HomeStart());
      }
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
      body: BlocProvider<HomeBloc>(
        create: (context) => _homeBloc,
        child: Column(
          children: <Widget>[
            TextFieldCustom(),
            BlocBuilder(
              bloc: _homeBloc,
              builder: (_, state) {
                if (state is HomeInitial) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                } else if ((state is HomeSuccess || state is HomeLoading) &&
                    _homeBloc.listSearchMovies.isEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: _homeBloc.listMovies.length,
                      itemBuilder: (_, index) => Column(
                        children: <Widget>[
                          MovieCard(movie: _homeBloc.listMovies[index]),
                          state is HomeLoading &&
                                  _homeBloc.listMovies.length - 1 == index
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                } else if (state is HomeFailure) {
                  return FailureWidget(
                    message:
                        "Unable to list movies, click the here to try again",
                    onTap: () {
                      _homeBloc.add(HomeStart());
                    },
                  );
                } else if ((state is HomeSearchSuccess ||
                        state is HomeLoading) &&
                    _homeBloc.listSearchMovies.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: _homeBloc.listSearchMovies.length,
                      itemBuilder: (_, index) => Column(
                        children: <Widget>[
                          MovieCard(movie: _homeBloc.listSearchMovies[index]),
                          state is HomeLoading &&
                                  _homeBloc.listSearchMovies.length - 1 == index
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
