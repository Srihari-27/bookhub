import 'dart:convert';

import 'package:bookhub/screens/searchfilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class searchloading_genre extends StatefulWidget {
  var text;
  searchloading_genre({@required this.text});

  @override
  State<searchloading_genre> createState() => _searchloading_genreState();
}

class _searchloading_genreState extends State<searchloading_genre> {
  var cp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    Response r = await get(
      Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:${widget.text}&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),

          //"https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),
    );

    cp = jsonDecode(r.body);
    print(cp);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return searchfilter(d: cp);
    }));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      body: Center(
        // ignore: prefer_const_constructors
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    ));
  }
}