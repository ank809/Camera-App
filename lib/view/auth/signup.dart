import 'package:camera_app/controllers/firebase_auth.dart';
import 'package:camera_app/view/auth/login.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  
  TextEditingController  emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  bool isPasswordVisible = true;

  final _formKey= GlobalKey<FormState>();

  void toggleVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
         decoration:const BoxDecoration(
          image: DecorationImage(image: AssetImage('Asset/register.png'),
          fit: BoxFit.cover)
         ),
         child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 150.0, left: 35.0),
                child: const Text(' Create \n Account',
              style: TextStyle(color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold),),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,
                    right: 40.0, left: 40.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            labelText: 'Enter your name',
                            labelStyle: TextStyle(color: Colors.black),
                            // fillColor: Colors.grey.shade100,
                            // filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                              return 'Enter your name';
                            } else {
                              return null;
                            }
                          }
                        ),
                        SizedBox(height: 30.0,),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Enter your email',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Please enter an email';
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
                            labelStyle: TextStyle(color: Colors.black),
                            // fillColor: Colors.grey.shade100,
                            // filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: toggleVisibility,
                          ),
                          ),
                          
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Please enter a password';
                            }
                            if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*]).{8,}$')
                              .hasMatch(value)) {
                            return 'Password must be 8 characters with upper, lower, number, and special char';
                          }
                          return null;
                          },
                        ),
                        SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Create Account',
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
                                _formKey.currentState!.validate();
                                Auth.instance.SignUp(nameController.text, emailController.text, passwordController.text);
                              },),
                            )
                          ],
                        ),
                        SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account ? ',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                            },
                             child: const Text('Login', 
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