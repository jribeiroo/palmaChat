


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

    //mapeando dados para para o banco
    Map<String, dynamic> data = {};
    
     if(imgFile != null){
       UploadTask task = FirebaseStorage.instance.ref().child(
         DateTime.now().millisecondsSinceEpoch.toString()
       ).putFile(File(imgFile.path));

        TaskSnapshot taskSnapshot = await task;
        String url = await taskSnapshot.ref.getDownloadURL();
        data['imgUrl'] = url;
     }

     if(text != null) {
       data['text'] = text;
     }
       
    FirebaseFirestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ola'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('messages').snapshots(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  // ignore: prefer_const_constructors
                  return Center(
                    // ignore: prefer_const_constructors
                    child: CircularProgressIndicator(),
                    );
                    default:
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(documents[index].data()['texto'] ?? ''),
                        );
                      }
                    );
                }
              },

            ),
            
            
            
            
            ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}
