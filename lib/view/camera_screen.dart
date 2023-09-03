import 'dart:developer';

import 'package:camera_app/main.dart';
import 'package:camera_app/view/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
 List<CameraDescription> cameras;
 Camera(this.cameras);


  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  int cam_index=0;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[cam_index], ResolutionPreset.ultraHigh);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container(); // You can show a loading indicator here
    }
    return Column(
          children:[ 
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Container(
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width,
            child: CameraPreview(_controller),
          ),
          SizedBox(height: 20.0,),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 39, 48, 55),
                onPressed: () async{
                  cam_index= 1-cam_index; // toggle between 0 and 1
                  await _controller.dispose();
                  _controller= CameraController(cameras[cam_index], ResolutionPreset.ultraHigh);

                  await _controller.initialize();
                 setState(() {
                   log(cam_index.toString());
                 });
                },
              child: Icon(Icons.switch_camera),),

              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 39, 47, 54),
                child:const  Icon(
                  Icons.camera_alt,
                ),
                onPressed: () async{
                  try{
                    final image= await _controller.takePicture();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>PreviewSScreen(imagepath: image.path)));
                  }catch(e){
                    e.toString();
                  }
                },
              ),
              
            ],
          ),
        )
          ],
      );
  }
}