import 'dart:developer';
import 'package:camera_app/main.dart';
import 'package:camera_app/model/users.dart';
import 'package:camera_app/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends GetxController{
  static Auth instance = Get.find();
  void SignUp(String name, String email, String password) async{
    try{
      if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
        UserCredential userCredential= await FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: email, password: password);

        MyUser myUser= MyUser(name: name, email: email, uid: userCredential.user!.uid);
        
        // to store data in firestore
        
        await FirebaseFirestore.instance.
        collection('users').doc(userCredential.user!.uid)
        .set(myUser.toJson()).then((value) =>
         Get.snackbar('Congratulations😀', 'You have successfully signed in'));
        Get.offAll(Home(cameras));
      }
      else{
        Get.snackbar('Incomplete details', 'Please fill all the required fields');
      }
    } catch(error){  // here error is just a variable
  log(error.toString());
    }
  }

  // Login Function 

  void login(String email, String password) async{
    try{
      if(email.isNotEmpty&& password.isNotEmpty){
        await FirebaseAuth.instance.signInWithEmailAndPassword
        (email: email, password: password).
        then((value) =>  Get.snackbar('Congratulations😀', 'You have successfully signed in'));
        Get.off(Home(cameras));
      }
      else{
        Get.snackbar('Incomplete details', 'Please fill all the required fields');
      }
    } catch(e){
      log(e.toString());
    }
  }

  // Google Sign in
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final GoogleSignIn googleSignIn= GoogleSignIn();
  Future<User?> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleSignInAccount=
       await googleSignIn.signIn();
       if(googleSignInAccount!=null){
          final GoogleSignInAuthentication googleSignInAuthentication= 
          await googleSignInAccount.authentication;
          final AuthCredential credential= GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken
            );
            final UserCredential authResult= await _auth.signInWithCredential(credential);
            final User? user= authResult.user;
            return user;
       }
    }catch(e){
      Get.snackbar('Google Sign In Failed', e.toString());
    }
  }
}