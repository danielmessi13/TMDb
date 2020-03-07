import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String message;
  final Color color;
  final Color colorText;

  const FailureWidget({
    Key key,
    this.colorText,
    this.color,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: EdgeInsets.zero,
      child: Card(
        elevation: 3,
        color: color ?? Colors.yellow[200],
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: colorText ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
