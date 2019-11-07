import 'package:flutter/material.dart';
import 'package:wallet/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E - Wallet",
      theme: ThemeData(
          // primaryColor: Colors.blue,
          
          ),
      home: Login(),
    );
  }
}

