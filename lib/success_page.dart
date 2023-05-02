import 'package:flutter/material.dart';

class success_page extends StatefulWidget {
  const success_page({Key? key}) : super(key: key);

  @override
  State<success_page> createState() => _success_pageState();
}

class _success_pageState extends State<success_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Text('success',style: TextStyle(fontSize: 60),),
    );
  }
}
