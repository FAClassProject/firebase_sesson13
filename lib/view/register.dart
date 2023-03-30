import 'dart:developer';

import 'package:firebase_sesson13/service/firebase_database.dart';
import 'package:firebase_sesson13/view/firebase_view.dart';
import 'package:firebase_sesson13/view/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final firebaseService = FireBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Please enter your name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.person),
              )
            ,),
          ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: TextField(
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
              bool isRegistered = await firebaseService.register(
                  nameController.value.text,
                  emailController.value.text,
                  passwordController.value.text);
              if(isRegistered){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FirebaseView()));
                print("name ${nameController.value.text}");
                print("email ${emailController.value.text}");
                print("password ${passwordController.value.text}");
              }
              log("registration Failed");
              print("failed name ${nameController.value.text}");
              print("failed email ${emailController.value.text}");
              print("failed password ${passwordController.value.text}");


            }, child: Text('Register')),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
            }, child: Text('Existing User? Login'))

        ],),),
    );
  }
}
