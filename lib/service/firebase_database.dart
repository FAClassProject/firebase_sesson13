import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

import '../model/user_model.dart';

class FireBaseService{
  DatabaseReference reference = FirebaseDatabase.instance.ref("/users");

  addUser(UserModel user){
    reference.child('/${user.id}').set(user.toMap());
  }

  Future<List<UserModel>> getUsers()async{
    List<UserModel> users = [];
    var data = await reference.get();
    List<DataSnapshot> snapshotdata = data.children.toList();
    print("printing  snapshotdata data ${snapshotdata.toString()}");
    for(var user in snapshotdata){
      users.add(UserModel.fromSnapshot(user));
      print("printing  snapshotdata data ${user.value}");
    }
    return users;
  }
}