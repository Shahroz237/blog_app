import 'package:blog_app/component/roundbutton.dart';
import 'package:blog_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final auth= FirebaseAuth.instance;

  final _key=GlobalKey<FormState>();
         bool loading=false;
        bool isPassVisible=true;
   final emailController=TextEditingController();
   final passController=TextEditingController();
   final nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height* 1;
    final width=MediaQuery.sizeOf(context).width* 1;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: height* .05,),
              Image(image: const AssetImage('assets/logo.png'),height: height * .2, width: width* .8,),

               Text('Register', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.deepOrange, fontStyle: FontStyle.italic)),
                  SizedBox(height: height * .03,),


            Form(

                key: _key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Email';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: height * .02,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.text,
                        obscureText: isPassVisible,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon:  IconButton(onPressed: (){
                              setState(() {
                                isPassVisible=!isPassVisible;
                              });
                            }, icon:isPassVisible ? const Icon(Icons.visibility): const Icon(Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Password';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: height * .02,),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            prefixIcon: const Icon(Icons.alternate_email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Name';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                )),

              SizedBox(height: height *.04,),

              roundbutton(title: 'Sign Up',
                  loading: loading, onTap: () {
                if(_key.currentState!.validate()){
                  setState(() {
                    loading=true;
                  });
                  auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString()).then((value){
                    setState(() {
                      loading=false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading=false;
                    });
                  });
                }
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
                }, child: const Text("Already have an account?Sign In", style: TextStyle(color: Colors.deepOrange),)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
