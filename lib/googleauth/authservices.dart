
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservices{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn=GoogleSignIn();

  Future<void> handleSignIn() async{
    try{
      GoogleSignInAccount? googleUser=await _googleSignIn.signIn();
      if(googleUser != null){
        GoogleSignInAuthentication googleauth= await googleUser.authentication;
      AuthCredential credential=  GoogleAuthProvider.credential(
          idToken: googleauth.idToken ,
          accessToken:googleauth.accessToken,
        );

      await _auth.signInWithCredential(credential);
      }
    }catch(e){
      print('Error signing in with google $e');
    }
  }


}