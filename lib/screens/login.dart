import 'package:blog_app/component/roundbutton.dart';
import 'package:blog_app/googleauth/auth.dart';
import 'package:blog_app/googleauth/authservices.dart';
import 'package:blog_app/screens/forgotpassword.dart';
import 'package:blog_app/screens/home.dart';
import 'package:blog_app/screens/register.dart';
import 'package:blog_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth= FirebaseAuth.instance;

  final _key=GlobalKey<FormState>();
  bool loading=false;
  bool isPassVisible=true;
  final emailController=TextEditingController();
  final passController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Authservices authservices=Authservices();
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

              Text('Login', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.deepOrange, fontStyle: FontStyle.italic)),
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
                      SizedBox(height: height * .03,),

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

            roundbutton(title: 'Login', onTap: (){
              if(_key.currentState!.validate()){
                setState(() {
                  loading=true;
                });

                auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString()).then((value){
                    setState(() {
                      loading=false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
                    Utils().toastMessage(value.user!.email.toString());
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }
            }),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()));
                            },
                            child:  const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                "Don't have an account?Sign up",
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            )),
                      ),

                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const forgotPassword()));
                          },
                          child:  const Text(
                            "forgot password?",
                            style: TextStyle(color: Colors.deepOrange),
                          )),


                      const Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        )
                      ),

                      SizedBox(height: height * .01,),

                      roundbutton(
                          title: 'Sign In With Google',
                          onTap: (){
                            authservices.handleSignIn();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AuthPage()));
                      })



                    ],
                  )
              ),







            ],
          ),
        ),
      ),
    );
  }


}
