import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_mark3_flutter/list_page.dart';
import 'package:sql_mark3_flutter/success_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Database.dart';

void main() {
  runApp(MaterialApp(home: MyApp(),) );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Database_class sqlDb = Database_class();

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  String username='';
  String password='';

  bool username_check=false;
  bool empty_check=false;

void validate(){
  if(formkey.currentState!.validate()){
    print("ok");
    empty_check=false;
  }
  else{
    print("error");
    empty_check=true;
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(

      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: textController1,
              onChanged: (textController1){
                username=textController1;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('username')
              ),
              validator: (val){
                if(val!.isEmpty){
                  return 'required';
                }
                else{
                  return null;
                }
              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: textController2,
              onChanged: (textController2){
                password=textController2;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('password')
              ),
              validator: (val){
                if(val!.isEmpty){
                  return 'required';
                }
                else{
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: ()async{
                    validate();
                  if(empty_check!=true){
                    var response = await sqlDb.check_data(username);
                    if(response.length==0){
                      int response_insert = await sqlDb.insertdata("INSERT INTO 'notes' Values('$username','$password')");
                      print(response_insert);
                      Fluttertoast.showToast(msg: "new account created");
                    }
                    else{
                      username_check=true;
                      Fluttertoast.showToast(msg: "user already exist");

                    }


                  }else{
                    return print('empty');
                  }

                  }, child: Text('create account')),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    var response = await sqlDb.check_data2(username,password);
                    if(response.length==0){
                      print('$response fail');
                    }
                    else{
                      username_check=true;
                      print('$response Success');
                      print('$username_check');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>success_page()));
                    }

                  }, child: Text('sign in')),
            ),
          ),

        ],
      ),
    ),


    );
  }
}
