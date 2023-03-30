import 'dart:developer';

import 'package:firebase_sesson13/view/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/firebase_database.dart';
import 'firebase_view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final firebaseService = FireBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: TextField(
              onChanged: (value) {

              },
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Please enter your email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.email),
              )
              ,),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: TextField(
              onChanged: (value) {

              },
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Please enter your password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.password),
              )
              ,),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            bool isRegistered = await firebaseService.login(
                emailController.value.text,
                passwordController.value.text);
            if(isRegistered){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FirebaseView()));
              print("email ${emailController.value.text}");
              print("password ${passwordController.value.text}");
            }
            log("Login Failed");
            print("email ${emailController.value.text}");
            print("password ${passwordController.value.text}");

          }, child: Text('Login')),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text('New User? Register'))

        ],),),
    );
  }
}
