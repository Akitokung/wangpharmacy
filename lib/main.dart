import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // ปิดแถวคาดแดง debud code ที่มุมบนขวา
    title: 'Wangpharmacy Hatyai',
    home: MyApp(),
  ));
}
// test comment
class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}
//d

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Login(), // ดึง class Login จากหน้า login มาทำงาน
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        //child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                    image: AssetImage('assets/images/frist-screen.jpg')
                )
            ),
          ),
        //),
      ),
    );
  }
}
