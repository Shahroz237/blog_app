import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'login.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final email3Controller=TextEditingController();
  final authenticate=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),

        leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [



          Padding(
            padding: const EdgeInsets.only(top: 159, left: 10, right: 10),
            child: TextFormField(
              controller: email3Controller,

              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
              ),

            ),
          ),

          const SizedBox(height: 10),

          InkWell(
            onTap: (){
              authenticate.sendPasswordResetEmail(email: email3Controller.text.toString()).then((value){
                Utils().toastMessage('We have send you email to recover password,check email');
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width*.9,
              decoration:  BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text('Forgot', style: TextStyle(color: Colors.white,fontSize: 17 ),)),
            ),
          )

        ],
      ),
    );
  }
}
