
import 'package:bookhub/screens/bookloading.dart';
import 'package:bookhub/screens/search_loading_for_genre.dart';
import 'package:bookhub/screens/search_loadinh.dart';
import 'package:bookhub/screens/search_loading_for_genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookhub/screen/home_screen.dart';

class homescreen extends StatefulWidget {
 
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();


  

  @override
  void initState() {
   
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: const Color.fromRGBO(158, 158, 158, 1),
      body: SafeArea(
          child: Column(
            children: [
              Container(
                
                color: Color.fromARGB(255, 182, 176, 176),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Container( 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: (() {
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop();
                                }),
                                child:
                                Icon(Icons.arrow_back, size: 30, color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                              onTap :(){
                                setState(() {
                                  
                                  print('1');
                                  
                                });
                              },
                              child:
                                Container(
                                  color: Color.fromARGB(255, 167, 171, 174),
                                  height: 70,

                      
                                  
                                 
                                  child:Center(
                                    child: Text('Home',
                                       style: TextStyle(
                                              fontSize: 20,
                                        ),
                                    
                                    ),
                                  )
     
                                  
                                ),

                   ),
                   
 
                   GestureDetector(
                              onTap :(){
                                setState(() {
                                  
                                  print('1');
                                  
                                });
                              },
                              child:
                                Container(
                                 color: Color.fromARGB(255, 167, 171, 174),
                                  height: 70,
                                  
                                 
                                  child:Center(
                                    child: Text('Favourites',
                                       style: TextStyle(
                                              fontSize: 20,
                                        ),
                                    
                                    ),
                                  )
     
                                  
                                ),

                   ),
                   
                   GestureDetector(
                              onTap :(){
                                setState(() {
                                  
                                  print('1');
                                  
                                });
                              },
                              child:
                                Container(
                                  color: Color.fromARGB(255, 167, 171, 174),
                                  height: 70,
                                  
                                  child:Center(
                                    child: Text('Brought',
                                       style: TextStyle(
                                              fontSize: 20,
                                        ),
                                    
                                    ),
                                  ),
     
                                  
                                ),

                   ),
                   

                   GestureDetector(
                              onTap :(){
                                setState(() {
                                  
                                  print('1');
                                  
                                });
                              },
                              child:
                                Container(
                                 color: Color.fromARGB(255, 167, 171, 174),
                                 height: 70,
                                  
                                  child:Center(
                                    child: Text('Create',
                                       style: TextStyle(
                                              fontSize: 20,
                                        ),
                                    
                                    ),
                                  )
     
                                  
                                ),

                   ),
                   ElevatedButton(
                       onPressed: () {
                        Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));

                       },
                       child: Icon(Icons.circle, color: Color.fromARGB(255, 152, 166, 177),),
                       style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor:Color.fromARGB(255, 152, 166, 177),
                        ),
                   )
                   
                   
                ],
                ),
              ),
              SizedBox(
                          height: 120,
              ),

              Container(

                 
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Do you wanna search book by bookname :",
                            style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(" Type below",
                            style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80.0),
                          
                          child: 
                          Container(
                            height: 40,
                            child: TextField(
                              controller: t1,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Search Book...",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(40))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return searchloading(text: t1.text);
                                }));
                          },
                          
                         
                          child: Text(
                            "SEARCH",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                        Text(
                          "OR",
                          style:  TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  
                ),
              
              SizedBox(
                          height: 30,
              ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Wanna search via Genre?",
                          style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: Container(
                          height: 40,
                          child: TextField(
                            controller: t2,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Search Genre",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return searchloading_genre(text: t2.text);
                              }));
                        },
                       
                        child: Text(
                          "SEARCH",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              
              
              
            ],
          )),
    ));
  }
}