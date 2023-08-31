import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:camera_app/firebase_options.dart';
import 'package:camera_app/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/firebase_auth.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  cameras = await availableCameras();
  runApp(MyApp());
}
  _initializeFirebase() async{
    await Firebase.initializeApp(options:
     DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(Auth()));
    log('Firebase Initialized');
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
 