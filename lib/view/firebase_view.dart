import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sesson13/model/user_model.dart';
import 'package:firebase_sesson13/service/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class FirebaseView extends StatefulWidget {
  const FirebaseView({Key? key}) : super(key: key);

  @override
  State<FirebaseView> createState() => _FirebaseViewState();
}

class _FirebaseViewState extends State<FirebaseView> {
  final dbService = FireBaseService();
  //final TextEditingController _idTextEditingController = TextEditingController();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _ageTextEditingController = TextEditingController();

  @override
  void initState() {
    dbService.getUsers();
    super.initState();
  }

  void showBottomSheetModel(String functionName, Function()? onPressed){
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_)=> Container(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom +120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _nameTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Name'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                controller: _ageTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Age'
                ),
              ),
              SizedBox(height: 10,),

              ElevatedButton(
                  onPressed: onPressed,
                  child: Text(functionName)
              )],
          ),
        ));
  }
  
  void addUser(){
    showBottomSheetModel("Add user", ()async{
      var user = UserModel(
          id: Uuid().v4(),
          name: _nameTextEditingController.value.text,
          email: _emailTextEditingController.value.text,
          age: int.parse(_ageTextEditingController.value.text));

      dbService.addUser(user);
      setState(() {
        print("Printing User saved Data ${user.email.toString()}");
        print("Printing User saved Data ${user.age.toString()}");
        print("Printing User saved Data ${user.name.toString()}");
        print("Printing User saved Data ${user.id.toString()}");
        _nameTextEditingController.clear();
        _emailTextEditingController.clear();
        _ageTextEditingController.clear();
        Navigator.of(context).pop();
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase demo'),),
      body: FutureBuilder(
        future: dbService.getUsers(),
          builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child:  CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(child: Text("No Data Found"));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var userData = snapshot.data![index];
                  return Card(
                    color: Colors.yellow[200],
                    child: ListTile(
                        title: Text("${userData.name } ${userData.age}"),
                         subtitle: Text("${userData.email }"),
                    ),
                  );

                });
          }
          return Center(child: Text("No Data Found"),);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: (){
          addUser();
          }),
    );
  }
}
