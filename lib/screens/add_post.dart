import 'dart:async';
import 'dart:io';

import 'package:blog_app/component/roundbutton.dart';
import 'package:blog_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postRef=FirebaseDatabase.instance.ref().child('Post');

  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  bool showSpinner=false;
  final titleController=TextEditingController();
  final desController=TextEditingController();
  File? _image;
 final _picker=ImagePicker();
 final _auth=FirebaseAuth.instance;

 Future getImageCamera() async{
   final pickedFile=await _picker.pickImage(source: ImageSource.camera);
   setState(() {
     if(pickedFile != null){
          _image=File(pickedFile.path);
     }else{
       print('No Image Selected');
     }
   });
 }

  Future getImageGallery() async{
    final pickedFile=await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        _image=File(pickedFile.path);
      }else{
        debugPrint('No Image Selected');
      }
    });
  }


  void dialog(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          height: MediaQuery.sizeOf(context).height * .2,
          child:  Column(
            children: [
              InkWell(
                onTap: (){
                  getImageCamera();
                  Navigator.pop(context);

                },
                child: const ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
              ),
              InkWell(
                onTap: (){
                    getImageGallery();
                    Navigator.pop(context);

                },
                child: const ListTile(
                  leading: Icon(Icons.photo_library_outlined),
                  title: Text('Gallery'),
                ),
              ),

            ],
          ),
        ),
      );
    }
    );

  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height* 1;
    final width=MediaQuery.sizeOf(context).width* 1;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Upload Blogs', style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              children: [
                 InkWell(
                   onTap: (){
                     dialog(context);
                   },
                   child: Center(
                     child: Container(
                       height: height* .2,
                       width: width,
                       child: _image != null ? ClipRRect(
                         child: Image.file(_image!.absolute,
                         width: 100,
                           height: 100,
                           fit: BoxFit.fill,
                         ),
                       ): Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                         width: 100,
                         height: 100,
                         child: const Icon(Icons.camera_alt, color: Colors.blue,),
                       ),
                     ),
                   ),
                 ),
                  SizedBox(height: height* .03,),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration:  const InputDecoration(
                          label: Text('Title'),
                          hintText: 'Enter Post Title',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                          labelStyle:  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),

                        ),
                      ),
                      SizedBox(height: height* .03,),
                      TextFormField(
                        controller: desController,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
                        decoration:  const InputDecoration(

                          label: Text('Description'),
                          hintText: 'Enter Post Description',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                          labelStyle:  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),

                        ),
                      ),



                    ],
                  ),
                ),

                SizedBox(height: height* .04,),
                roundbutton(title: 'Upload', onTap: ()async{
                  setState(() {
                    showSpinner=true;
                  });

                  try{
                  int date=DateTime.now().microsecondsSinceEpoch;
                  firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/blogapp$date');
                  UploadTask uploadTask=ref.putFile(_image!.absolute);
                  await Future.value(uploadTask);
                  var newUrl= await ref.getDownloadURL();
                final User?  user=_auth.currentUser;
                  postRef.child('PostList').child(date.toString()).set({
                    'pId': date.toString(),
                    'pImage': newUrl.toString(),
                    'pTime': date.toString(),
                    'pTitle': titleController.text.toString(),
                    'pDescription': desController.text.toString(),
                    'uEmail': user!.email.toString(),
                    'uId': user.uid.toString(),

                  }).then((value){

                    Utils().toastMessage('Post Published');
                    setState(() {
                      showSpinner=false;
                    });
                  }).onError((error, stackTrace){
                    setState(() {
                      showSpinner=false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                  }catch(e){

                    Utils().toastMessage(e.toString());
                    setState(() {
                      showSpinner=false;
                    });
                  }

                }),

              ],
            ),
          ),
        ),
      ),
    );
  }




}
