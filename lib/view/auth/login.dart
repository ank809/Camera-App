import 'package:camera_app/controllers/firebase_auth.dart';
import 'package:camera_app/view/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController  emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
         decoration:const BoxDecoration(
          image: DecorationImage(image: AssetImage('Asset/login.png'),
          fit: BoxFit.cover)
         ),
         child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 150.0, left: 35.0),
                child: const Text('Welcome \n Back',
              style: TextStyle(color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold),),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,
                  right: 40.0, left: 40.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Enter your email',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       TextButton(onPressed:null, child:Text('Forgot Password?', 
                        style: TextStyle(
                          color: Color.fromARGB(255, 69, 67, 67),
                        ),),
                        ),
                      ],),
                      SizedBox(height: 30.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sign In',
                          style: TextStyle(
                            color: Color.fromARGB(255, 69, 67, 67),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),),
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Color.fromARGB(255, 54, 52, 52),
                            child: IconButton(icon: Icon(Icons.arrow_forward),
                            color: Colors.white,
                            onPressed: (){
                              Auth.instance.login(emailController.text, passwordController.text);
                            },),
                          )
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have account ? ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),),
                          TextButton(onPressed: (){
                            Get.off(SignUp());
                          },
                           child: const Text('Sign Up', 
                           style: TextStyle(
                            color:Color.fromARGB(255, 69, 67, 67),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                            ),
                            ),
                            ),
                      ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
         ),
        );
  }
}