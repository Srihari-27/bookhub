import 'package:flutter/material.dart';

class favbook_nothing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Favourites'),
        ),
        body: Center(
          child: Text(
            'Nothing Available',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}