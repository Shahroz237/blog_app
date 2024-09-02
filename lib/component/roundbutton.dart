import 'package:flutter/material.dart';

class roundbutton extends StatelessWidget {
  final String title;
   bool loading;
  final VoidCallback onTap;
   roundbutton({super.key, required this.title, required this.onTap, this.loading=false});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height* 1;
    final width=MediaQuery.sizeOf(context).width* 1;

    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onTap: onTap,
          child:loading ? const CircularProgressIndicator(strokeWidth: 4,): Container(
            height: height * .08,
            width: width* .9,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            )
          ),
        ),
      );
  }
}
