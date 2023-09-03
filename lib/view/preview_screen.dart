import 'dart:io';

import 'package:flutter/material.dart';
class PreviewSScreen extends StatelessWidget {
  final String imagepath;
  const PreviewSScreen({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 45, 54),
      appBar: AppBar(title:Text('Preview your picture'),
      backgroundColor: Colors.yellow,),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            width: MediaQuery.of(context).size.width,
            color: Colors.yellow.shade50,
             child: Image.file(File(imagepath),
            fit: BoxFit.cover,)
          ),
        ],
      ),
    );
  }
}