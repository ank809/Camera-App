import 'package:camera_app/view/camera_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
var camera;
 Home(this.camera);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 46, 64, 78),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:Camera(widget.camera) ,
    );
  }
}