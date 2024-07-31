import 'dart:convert';
//import 'dart:ffi';

class User {
  final String id;
  final String name;
  final String email;
  final String token;
  final String password;
  final String forgotpass;
  User({
    required this.forgotpass, required this.id, required this.name, required this.email, required this.token, required this.password,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'password': password,
      //'id':id,
      'forgotpass': forgotpass,
      
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      forgotpass: map['forgotpass'] ?? ''

    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}