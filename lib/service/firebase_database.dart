

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/user_model.dart';

class FireBaseService{
  final FirebaseAuth auth = FirebaseAuth.instance;
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
  Future<bool> register(String name, String email, String password)async{
    auth.currentUser!.reload();
    try{
      var userCredentials = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await auth.currentUser!.updateDisplayName(name);
      if(userCredentials.user != null){
        print("email ${email}");
        print("password ${password}");

        return true;

      }
      print("false email ${email}");
      print("false password ${password}");
      return false;

    }catch(e){
      print("catch email ${email}");
      print("catch password ${password}");
      print(e);
      return false;
    }

  }

  Future<bool> login(String email, String password)async{
    //auth.currentUser!.reload();
    try{
      var userCredentials = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(userCredentials.user != null){
        print("email ${email}");
        print("password ${password}");
        return true;
      }else{
        print("False Block email ${email}");
        print("false Block password ${password}");
      }
      return false;

    }catch(e){
      print("Catch Block email ${email}");
      print("Catch Block password ${password}");
      print(e);
      return false;
    }

  }
  Future signOut()async{
    await auth.signOut();

  }

}