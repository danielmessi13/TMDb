import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
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
                controller: _messageController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Search for a movie",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
