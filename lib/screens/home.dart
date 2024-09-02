import 'package:blog_app/screens/add_post.dart';
import 'package:blog_app/screens/login.dart';
import 'package:blog_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth=FirebaseAuth.instance;
  final firebaseRef=FirebaseDatabase.instance.ref().child('Post');
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height * 1;
    final width=MediaQuery.sizeOf(context).width * 1;

    return  Scaffold(
         appBar:AppBar(
           backgroundColor: Colors.deepOrange,
           title: const Text('New Blogs', style: TextStyle(color: Colors.white, fontSize: 20),),

             leading: IconButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
             },
               icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
             ),
           actions: [
             IconButton(onPressed: (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPost()));
             }, icon: const Icon(Icons.add,color: Colors.white,)),
             const SizedBox(width: 20,),
             IconButton(onPressed: (){
               _auth.signOut().then((value){
                 Utils().toastMessage('Logout');
                 setState(() {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));

                 });
               });
             }, icon: const Icon(Icons.logout_outlined), color: Colors.white,)
           ],
         ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: firebaseRef.child('PostList'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            height: height * .30,
                              width: width,
                              fit: BoxFit.cover,
                              placeholder: 'assets/logo.png',
                              image: snapshot.child('pImage').value.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(snapshot.child('pTitle').value.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(snapshot.child('pDescription').value.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
                        ),

                      ],
                    );
                  }
                ),
          )

        ],
      ),
    );
  }
}
