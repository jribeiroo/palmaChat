// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(this.data, {Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(data['senderPhotoUrl']),
          ),
          Expanded(
            child: Column(
              children: [
                data['imgUrl'] != null
                    ? Image.network(data['imgUrl'])
                    : Text(
                        data['text'],
                        style: TextStyle(fontSize: 16),
                      ),
                Text(
                  data['senderName'],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
