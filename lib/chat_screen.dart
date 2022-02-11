


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:palma_chat/text_composer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  _sendMessage({String? text, PickedFile? imgFile}) async {
    
     if(imgFile != null){
       UploadTask task = FirebaseStorage.instance.ref().child(
         DateTime.now().millisecondsSinceEpoch.toString()
       ).putFile(File(imgFile.path));

        TaskSnapshot taskSnapshot = await task;
        String url = await taskSnapshot.ref.getDownloadURL();
        if (kDebugMode) {
          print(url);
        }

     }

    FirebaseFirestore.instance.collection('messages').add({
      'text' : text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ola'),
        elevation: 0,
      ),
      body: TextComposer(_sendMessage),
    );
  }
}
