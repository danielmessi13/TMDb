import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/src/home/bloc/home_bloc.dart';

class TextFieldCustom extends StatefulWidget {
  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.teal[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.search, color: Colors.white),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Search for a movie",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    BlocProvider.of<HomeBloc>(context).add(HomeClear());
                  } else {
                    BlocProvider.of<HomeBloc>(context).add(
                      HomeSearch(query: _searchController.text),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
