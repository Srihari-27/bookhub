
import 'package:flutter/material.dart';
import 'package:bookhub/providers/users_provider.dart';
import 'package:provider/provider.dart';
import 'package:bookhub/screen/home_screen.dart';
import 'package:bookhub/screen/signup.dart';
import 'package:bookhub/providers/users_provider.dart';



import 'package:bookhub/screens/loadingscreen.dart';
import 'package:bookhub/screens/homescreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Node Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.user.token.isEmpty) {
            return  SignupScreen();
            //print('hello');
          } else {
            return  HomeScreen();
          }
        },
      ),
    );
  }
}
/*
void main() => runApp(MaterialApp(
    initialRoute:'/loadingscreen',
    routes:{
      //'/final':(context) => Finale(a:'SAMOSA'),
      //'/home': (context)  => Home(),
      '/start': (context) =>Start(),
      '/update1':(context) =>Update(),
      //'/splashscreen':(context) =>splashscreen(),
      '/loadingscreen':(context) =>LoadingScreen(),

    }
));*/
/*
Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user.id),
          Text(user.email),
          Text(user.name),
          ElevatedButton(
            onPressed: () => signOutUser(context),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              textStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),*/



