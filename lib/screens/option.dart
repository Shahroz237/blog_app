import 'package:blog_app/component/roundbutton.dart';
import 'package:blog_app/googleauth/auth.dart';
import 'package:blog_app/screens/login.dart';
import 'package:blog_app/screens/register.dart';
import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
     bool loading=false;
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height* 1;
    final width=MediaQuery.sizeOf(context).width* 1;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

               Image(
                  height: height * .4,
                  width: width* .9,
                  image: const AssetImage('assets/logo.png',)),

               roundbutton(title: 'Register',
                   loading: loading,
                   onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()));
               }),
               SizedBox(height: height * .09,),
              roundbutton(title: 'Login', onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));

              }, loading: loading,),


            ],
          ),
        ),
      ),
    );
  }
}
