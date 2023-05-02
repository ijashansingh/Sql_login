import 'dart:ffi';

import 'package:flutter/material.dart';

import 'Database.dart';

class list_page extends StatefulWidget {
  const list_page({Key? key}) : super(key: key);

  @override
  State<list_page> createState() => _list_pageState();
}

class _list_pageState extends State<list_page> {
  Database_class sqlDb = Database_class();
  List<Map> response=[];

  var list;


  @override
  Widget build(BuildContext context) {
    data_check();
    return Scaffold(
     body:  ListView.builder(
        // itemCount: snapshot.data!.snapshot.children.length,
        itemCount: response.length,
        itemBuilder: (context, index) {

          return ListTile(title:
          Text(response as String), textColor: Colors.black,
          );
        }

      // subtitle: Text(index.toString(),style: TextStyle(color: Colors.red),),
      // leading: video_control(),
    )

    );
  }

  data_check() async {
    if(response!=null){
      response =  await sqlDb.readdata("SELECT * FROM 'notes'");
      print(response);

  }}
}
