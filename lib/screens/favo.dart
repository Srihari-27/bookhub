/*import 'dart:io' as i;
import 'package:bookhub/screens/homescreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class favbookdisplay extends StatefulWidget {
  var  d;
  favbookdisplay({required this.d});

  @override
  State<favbookdisplay> createState() => _favbookdisplayState();
}

class _favbookdisplayState extends State<favbookdisplay> {
  var desc = "Not available";
  bool isFavorited = false;
  var url =
      "https://www.bing.com/images/search?view=detailV2&ccid=vx9%2fIUj5&id=3B7650A146D55682645F765E60E786419299154C&thid=OIP.vx9_IUj50utS7cbaiRtoZAHaE8&mediaurl=https%3a%2f%2fst3.depositphotos.com%2f1186248%2f14351%2fi%2f950%2fdepositphotos_143511907-stock-photo-not-available-rubber-stamp.jpg&exph=682&expw=1023&q=not+available&simid=608054098357136066&FORM=IRPRST&ck=BADF0353AC59677CCFAA67227357E3CB&selectedIndex=1&ajaxhist=0&ajaxserp=0";
  @override
  void initState() {
    super.initState();
    if (widget.d != null && widget.d["items"] != null && widget.d["items"].isNotEmpty) {
      
      getdesc();
      
      
      
      geturl();
    }
  }

  void geturl() {
    try {
      if (widget.d["items"] != null && widget.d["items"].isNotEmpty) {
        var imageLinks = widget.d["items"][0]["volumeInfo"]["imageLinks"];
        if (imageLinks != null) {
          url = imageLinks["thumbnail"] ?? url;
        }
      }
    } catch (e) {
      print("Error fetching URL: $e");
    }
  }

  

  

  void getdesc() {
    try {
      if (widget.d["items"] != null && widget.d["items"].isNotEmpty) {
        var description = widget.d["items"][0]["volumeInfo"]["description"];
        if (description != null) {
          setState(() {
            desc = description.toString();
          });
        }
      }
    } catch (e) {
      print("Error fetching description: $e");
    }
  }

 

  

  Future openfile(var url, var title) async {
    final file = await downloadfile(url, title!);
    if (file == null) {
      print("null");
      return;
    }
    print(file.path);
    OpenFile.open(file.path);
  }

  Future<i.File?> downloadfile(var url, var filename) async {
    try {
      var appstorage = await getApplicationDocumentsDirectory();
      
      final file = i.File('${appstorage.path}/filename');
      final Response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: Duration(milliseconds: 1000),
            
          ));
      final raf = file.openSync(mode: i.FileMode.write);
      raf.writeFromSync(Response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Color(0xfff012ac0),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: 
        ElevatedButton(
          onPressed: () async {
            await launchUrl(
                Uri.parse(widget.d["items"][0]["accessInfo"]["webReaderLink"]));
          },
          
          //color: Colors.black,
          child: Text(
            "READ BOOK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      "DETAILS",
                      style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          var url = widget.d["items"][0]["accessInfo"]["epub"]
                          ["isAvailable"];
                          if (url == true) {
                            url = widget.d["items"][0]["accessInfo"]["epub"]
                            ["acsTokenLink"];
                            await launchUrl(Uri.parse(url));
                          }
                        } catch (e) {
                          print("Not available");
                        }
                      },
                      child: const Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 230,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  url,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            widget.d["items"][0]["volumeInfo"]["title"],
                            style:  TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),

                        Text(
                            "by " +
                                widget.d["items"][0]["volumeInfo"]["authors"][0],
                            style:  TextStyle(
                                fontSize: 15, color: Colors.grey[400])),

                        SizedBox(
                          height: 20,
                        ),
                        IconButton(
                        icon: Icon(
                             isFavorited ? Icons.favorite : Icons.favorite_border,
                             color: isFavorited ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                            setState(() {
                                 isFavorited = !isFavorited;
                            });
                        },
                       //iconSize: 100.0,
                       ),
                        
                        
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 25),
                            child: ListView(
                              children: [
                                Text(
                                    "What's it about?",
                                    style:  TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    )),

                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  desc,
                                  style:TextStyle(
                                      color: Colors.grey[600], fontSize: 15),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}*/