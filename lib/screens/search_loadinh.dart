import 'dart:convert';

import 'package:bookhub/screens/searchfilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class searchloading extends StatefulWidget {
  var text,email;
  searchloading({@required this.text, @required this.email});

  @override
  State<searchloading> createState() => _searchloadingState();
}

class _searchloadingState extends State<searchloading> {
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
        
          "https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),
          //"https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),
    );

    cp = jsonDecode(r.body);
    print("life mukiyum bigullu");
    print(cp);
    print('working in search_loading11');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      print('working in search_loading');
      return searchfilter(d: cp,email:widget.email);
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
