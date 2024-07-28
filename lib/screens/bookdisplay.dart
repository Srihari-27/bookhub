import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDisplay extends StatefulWidget {
  final dynamic d;

  BookDisplay({required this.d});

  @override
  _BookDisplayState createState() => _BookDisplayState();
}

class _BookDisplayState extends State<BookDisplay> {
  String pagecount = "Not available";
  String desc = "Not available";
  String pubdate = "Not available";
  String lang = "Not available";
  String rating = "Not available";
  String url =
      "https://www.bing.com/images/search?view=detailV2&ccid=vx9%2fIUj5&id=3B7650A146D55682645F765E60E786419299154C&thid=OIP.vx9_IUj50utS7cbaiRtoZAHaE8&mediaurl=https%3a%2f%2fst3.depositphotos.com%2f1186248%2f14351%2fi%2f950%2fdepositphotos_143511907-stock-photo-not-available-rubber-stamp.jpg&exph=682&expw=1023&q=not+available&simid=608054098357136066&FORM=IRPRST&ck=BADF0353AC59677CCFAA67227357E3CB&selectedIndex=1&ajaxhist=0&ajaxserp=0";

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    getDetails();
    getUrl();
  }

  void getDetails() {
    try {
      var volumeInfo = widget.d["items"][0]["volumeInfo"];

      setState(() {
        pagecount = volumeInfo["pageCount"]?.toString() ?? "Not available";
        desc = volumeInfo["description"] ?? "Not available";
        pubdate = volumeInfo["publishedDate"]?.toString() ?? "Not available";
        lang = volumeInfo["language"]?.toString()?.toUpperCase() ?? "Not available";
        rating = volumeInfo["averageRating"]?.toString() ?? "Not available";
      });
    } catch (e) {
      print("Error fetching book details: $e");
    }
  }

  void getUrl() {
    try {
      var thumbnail = widget.d["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"];
      setState(() {
        url = thumbnail;
      });
    } catch (e) {
      print("Error fetching thumbnail URL: $e");
    }
  }

  Future<void> openFile(String url, String title) async {
    try {
      final file = await downloadFile(url, title);
      if (file != null) {
        print("Opening file: ${file.path}");
        OpenFile.open(file.path);
      } else {
        print("File download failed or file is null");
      }
    } catch (e) {
      print("Error opening file: $e");
    }
  }

  Future<io.File?> downloadFile(String url, String filename) async {
    try {
      var appStorage = await getApplicationDocumentsDirectory();
      final file = io.File('${appStorage.path}/$filename');
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(milliseconds: 10000),
        ),
      );
      await file.writeAsBytes(response.data);
      return file;
    } catch (e) {
      print("Error downloading file: $e");
      return null;
    }
  }

  Future<void> launchUrl(Uri uri) async {
    try {
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      } else {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff012ac0),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: ElevatedButton(
          onPressed: () async {
            var webReaderLink = widget.d["items"][0]["accessInfo"]["webReaderLink"];
            await launchUrl(Uri.parse(webReaderLink));
          },
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    "DETAILS",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        var epub = widget.d["items"][0]["accessInfo"]["epub"];
                        if (epub != null && epub["isAvailable"]) {
                          var acsTokenLink = epub["acsTokenLink"];
                          await launchUrl(Uri.parse(acsTokenLink));
                        } else {
                          print("Epub not available");
                        }
                      } catch (e) {
                        print("Error fetching epub details: $e");
                      }
                    },
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
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
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.d["items"][0]["volumeInfo"]["title"],
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "by ${widget.d["items"][0]["volumeInfo"]["authors"][0]}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDetail("Rating", rating),
                          _buildDetail("Pages", pagecount),
                          _buildDetail("Language", lang),
                          _buildDetail("Publish date", pubdate.toUpperCase()),
                          ElevatedButton(
                            child: Text('Elevated Button'),
                            onPressed: () {
                               print('Pressed');
                            },
                            style: ButtonStyle(
                                     backgroundColor: WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                          if (states.contains(WidgetState.pressed)) return Colors.red;
                                             return Colors.white;
                                    },
                              ),
                            ),
       
                          
                       )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What's it about?",
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        desc,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
