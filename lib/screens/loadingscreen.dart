import 'dart:convert';

import 'package:bookhub/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class loadingscreen extends StatefulWidget {
  //var l;
  //loadingscreen({@required this.l});

  @override
  State<loadingscreen> createState() => _loadingscreenState();
}

class _loadingscreenState extends State<loadingscreen>
    with SingleTickerProviderStateMixin {
  /*late AnimationController c;
  var c1;
  var c2;
  var c3;
  var c4;*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getcategorydata();
    homescreen();

  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child:CircularProgressIndicator(
                  color: Colors.black,
                )
            )
          ],
        ),
      ),
    ));
  }
}

