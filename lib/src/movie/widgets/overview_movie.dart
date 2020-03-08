
import 'package:flutter/material.dart';

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
