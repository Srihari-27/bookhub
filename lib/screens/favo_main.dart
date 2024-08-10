import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bookhub/screens/bookloading.dart';
import 'package:bookhub/screens/error.dart';
import 'package:bookhub/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:bookhub/providers/users_provider.dart';

class SearchFav extends StatefulWidget {
  List c; 

  SearchFav({required this.c});

  @override
  State<SearchFav> createState() => _SearchFavState();
}

class _SearchFavState extends State<SearchFav> {
  final AuthService authService = AuthService();
  var d;
  var i;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    try {
      d=widget.c;
    } catch (e) {
      print("Failed to decode JSON: $e");
    }
    print(d); 
  }
  //var d;
  /*@override
  void initState(){
    super.initState();
    final user = Provider.of<UserProvider>(context).user;
    d=user.liked;
    print(d);
  }*/

  void getI(int index) {
    try {
      setState(() {
        i = d["items"][index + 1]["volumeInfo"]["industryIdentifiers"][0]["identifier"];
      });
    } catch (e) {
      print('Error in getI: $e');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return error();
      }));
    }
  }

  String st(String s) {
    return s.length > 20 ? s.substring(0, 20) + "..." : s;
  }

  @override
  Widget build(BuildContext context) {
    /*final user = Provider.of<UserProvider>(context).user;
    d=user.liked;
    print(d);*/
    if (d == null) {
      return Scaffold(body: Center(child: Text('No items to display')),);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "FAVOURITES",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "..",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: d["items"].length - 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 270,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 139, 140, 144),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 210,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: d != null &&
                                          d["items"] != null &&
                                          d["items"].length > index + 1 &&
                                          d["items"][index + 1]["volumeInfo"] != null &&
                                          d["items"][index + 1]["volumeInfo"]["imageLinks"] != null &&
                                          d["items"][index + 1]["volumeInfo"]["imageLinks"]["thumbnail"] != null
                                      ? NetworkImage(d["items"][index + 1]["volumeInfo"]["imageLinks"]["thumbnail"])
                                      : AssetImage('assets/placeholder.jpg') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25),
                                Flexible(
                                  child: Text(
                                    st(d["items"][index + 1]["volumeInfo"]["title"] ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Flexible(
                                  child: Text(
                                    "by " + st(d["items"][index + 1]["volumeInfo"]["authors"][0] ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        getI(index);
                                        /*Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                          //return BookLoading(c: i);
                                        }));*/
                                      },
                                      child: Text(
                                        "DETAILS",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isPressed ? Icons.favorite : Icons.favorite_border,
                                        color: isPressed ? Colors.red : Colors.grey,
                                      ),
                                      iconSize: 50.0,
                                      onPressed: () {
                                        setState(() {
                                          isPressed = !isPressed;
                                        });
                                        // fav(d); // Handle the fav function accordingly
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}


