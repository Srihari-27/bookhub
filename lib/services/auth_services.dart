import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bookhub/models/users.dart';
import 'package:bookhub/providers/users_provider.dart';
import 'package:bookhub/screen/home_screen.dart';
import 'package:bookhub/screen/signup.dart';
import 'package:bookhub/utils/constants.dart';
import 'package:bookhub/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookhub/screens/homescreen.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        token: '',
      );
      print('connected with signup user');

      http.Response res = await http.post(
        //print('connected with signup user'),
        //http://localhost:3000
        Uri.parse('http://10.0.2.2:3000/api/signup'),
        //Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
      );
      print('connected with signup user3');

      if (context.mounted) {
        print("connected with signup user2");
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account created! Login with the same credentials!',
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>  homescreen(),
                ),
                (route) => false,
              );
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
        token = '';
      }

      var tokenRes = await http.post(
        //http://10.0.2.2:3000/api/signup
        Uri.parse('http://10.0.2.2:3000/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('http://10.0.2.2:3000/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        if (context.mounted) {
          userProvider.setUser(userRes.body);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SignupScreen(),
        ),
        (route) => false,
      );
    }
  }

  Future<void> update1({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String id,
    //required String newname,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        token: '',
      );
      //print('connected with signup user');
/*
      http.Response res = await http.post(
        //print('connected with signup user'),
        //http://localhost:3000
        Uri.parse('http://10.0.2.2:3000/api/signup'),
        //Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
      );
      print('connected with signup user3');
      */
      final res = await http.post(
          Uri.parse('http://10.0.2.2:3000/api/update'),
          headers: <String, String>{
                 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        //'newUsername': newname,
        'password':password,
        'email': email,
        'id':id,

      }),
    );
      

      if (context.mounted) {
        //print("connected with signup user2");
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account updated! Login with the same credentials!',
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<void> delete1({
    required BuildContext context,
    required String id
    }) async {
     // User user =User()
    //final String _id = _idController.text;

    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter an ID')),
      );
      return;
    }

    final url = 'http://10.0.2.2:3000/api/delete'; // Replace with your server IP
    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'_id': id}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user')),
      );
    }
  }
}
