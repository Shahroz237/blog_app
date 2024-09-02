import 'package:blog_app/screens/splashservices.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashServices splashscreen=splashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.isLogin(context);

  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height* 1;
    final width=MediaQuery.sizeOf(context).width* 1;

    return   Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 88.0),
            child: Center(
              child: Image(
                  height:height * .25,
                  width: width *.30,
                  image: const AssetImage('assets/splash.png',)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
