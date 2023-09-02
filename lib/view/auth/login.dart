import 'package:camera_app/controllers/firebase_auth.dart';
import 'package:camera_app/view/auth/signup.dart';
import 'package:camera_app/view/reset_password.dart';
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

  final _formkey= GlobalKey<FormState>();
  bool isPasswordVisible=true;
  
  void toggleVisibility(){
setState(() {
      isPasswordVisible=!isPasswordVisible;
});
  }
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
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Enter your email',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter your email';
                            }
                            if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Enter your password',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            suffixIcon: IconButton(icon:Icon(
                              isPasswordVisible? Icons.visibility: Icons.visibility_off),
                            onPressed: toggleVisibility,)
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Please Enter your password';
                            }
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*]).{8,}$')
                                .hasMatch(value)) {
                              return 'Password must be 8 characters with upper, lower, number, and special char';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         TextButton(onPressed:(){
                          Get.off(ResetPassword());
                         },
                          child:const Text('Forgot Password?', 
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
                                _formkey.currentState!.validate();
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
                ),
              )
            ],
          ),
         ),
        );
  }
}