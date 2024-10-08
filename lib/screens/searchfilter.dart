import 'package:bookhub/screens/bookloading.dart';
import 'package:bookhub/screens/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookhub/services/auth_services.dart';

class searchfilter extends StatefulWidget {
  var d;
  var email;
  searchfilter({@required this.d,@required this.email});
 // fav({required this.d});

  @override
  State<searchfilter> createState() => _searchfilterState();
}

class _searchfilterState extends State<searchfilter> {
  final AuthService authService = AuthService();
  var i;
  bool isPressed =false;
  
  void fav(Map d) {
    print("yes11");
    print(d);
    print(widget.email);
    print("as of now we are in filter");
    authService.favourites1(
        context: context,
        liked: d,
        email: widget.email ?? '', 
    );
  }
  

  geti(int index) {
    try {
      setState(() {
        print('working in searchfilter true');
        i = widget.d["items"][index + 1]["volumeInfo"]["industryIdentifiers"]
        [0]["identifier"];
      });
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        print('working in searchfilter false');
        return error();
      }));
    }
  }

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 20) {
        break;
      }
      count++;
      ans = ans + s[i];
    }
    return ans + "...";
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                      "RESULT",
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.d["items"].length ,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: (Container(
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
                                  image: widget.d != null &&
                                  widget.d["items"] != null &&
                                  widget.d["items"].length > index + 1 &&
                                  widget.d["items"][index + 1]["volumeInfo"] != null &&
                                  widget.d["items"][index + 1]["volumeInfo"]["imageLinks"] != null &&
                                  widget.d["items"][index + 1]["volumeInfo"]["imageLinks"]["thumbnail"] != null
                                  ? NetworkImage(widget.d["items"][index + 1]["volumeInfo"]["imageLinks"]["thumbnail"])
                                  :AssetImage('assets/placeholder.jpg'), // Fallback image in case of null
                                  fit: BoxFit.cover,
                                  ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Flexible(
                                  child: Text(
                                    

                                    (widget.d["items"][index + 1]["volumeInfo"]
                                    ["title"])
                                        .length >
                                        20
                                        ? st(widget.d["items"][index + 1]
                                    ["volumeInfo"]["title"])
                                        : widget.d["items"][index + 1]
                                    ["volumeInfo"]["title"],
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    (widget.d["items"][index + 1]["volumeInfo"]
                                    ["authors"][0])
                                        .length >
                                        20
                                        ? "by " +
                                        st(widget.d["items"][index + 1]
                                        ["volumeInfo"]["authors"][0])
                                        : "by " +
                                        widget.d["items"][index + 1]
                                        ["volumeInfo"]["authors"][0],
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                                
                                SizedBox(
                                  height: 10,
                                ),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:[
                                  ElevatedButton(
                                  onPressed: () {
                                    geti(index);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return bookloading(c: i,);
                                        }));
                                  },
                                  //color: Colors.black,
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
                                     onPressed: (){
                                      fav(widget.d);
                                     },
                                ),

                                ])
                              ],
                            )
                          ],
                        ),
                      )),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
} 
