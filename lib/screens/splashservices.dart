import 'dart:async';

import 'package:blog_app/screens/home.dart';
import 'package:blog_app/screens/option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class splashServices{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3),
            () =>
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home())),
      );
    }else{
      Timer(const Duration(seconds: 3),
            () =>
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Option())),
      );
    }

  }
}