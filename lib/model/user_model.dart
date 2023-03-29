import 'package:firebase_database/firebase_database.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;



  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age});

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      UserModel(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          age: data['age']);

  factory UserModel.fromSnapshot(DataSnapshot data) => UserModel(
      id: data.child('id').value as String,
      name: data.child('name').value as String,
      email: data.child('email').value as String,
      age: data.child('age').value as int);


  Map<String, dynamic> toMap() =>{
    'id':id,
    'name':name,
    'email':email,
    'age':age
  };
}