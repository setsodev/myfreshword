import 'package:flutter/material.dart';

class User {
  String id;
  String churchid;
  String imgUrl;
  String token;

  User({this.id, this.churchid, this.imgUrl, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        churchid: json['churchid'],
        imgUrl: json['image_url'],
        token: json['token']);
  }
}

class SignUpUser {
  int status;
  String message;

  SignUpUser({this.status, this.message});

  factory SignUpUser.fromJson(Map<String, dynamic> json) {
    return SignUpUser(status: json['status'], message: json['message']);
  }
}
