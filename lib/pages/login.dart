import 'dart:convert';
import 'dart:io';
import 'package:wallet/models/config.dart';

import 'package:flutter/material.dart';
import 'package:wallet/pages/home.dart';
import 'package:wallet/pages/register.dart';
import 'package:wallet/widgets/circle.dart';
import 'package:wallet/colors.dart';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController accountEmail = new TextEditingController();

  TextEditingController accountPassword = new TextEditingController();

  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        new CircleBack(),
        Container(
          width: MediaQuery.of(context).size.width,
          // color: Colors.blueGrey.withOpacity(0.5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: accountEmail,
                              keyboardType: TextInputType.emailAddress,

                             decoration: InputDecoration(
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50)))),
                      ),
                      TextField(
                        controller: accountPassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50)))),
                      ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 30,
                            // backgroundColor: Colors.black12,
                            child: Center(child: load ? CircularProgressIndicator(backgroundColor: Colors.white,) : Icon(Icons.arrow_forward_ios)),
                          ),
                          onTap: ()async {    
                            load = !load;
                            setState(() {
                              
                            });
                            try {
                              String basicAuth = 'Basic '+base64Encode(utf8.encode('${accountEmail.text}:${accountPassword.text}'));
                              http.Response r = await http.get("http://$ip/accounts/login",headers: <String, String>{'authorization': basicAuth});
                              print(r.statusCode);
                              print(r.body);
                              if (r.statusCode == 200){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                              } else if(r.statusCode == 401){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Wrong Credentials"),
                                      content: Text("Check your email or password"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else{
                                print ("Another error");
                              }
                              
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Connection erroe"),
                                      content: Text("Check your internet connection"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                            }
                            load = false;
                            setState(() {
                              
                            });                           
                          },
                        ),
                      )
                    ],
                    
                  ),
                ),
                InkWell(
                  onTap: (){
                    print("this is it");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 120, top: 20),
                    child: Text("Forgot password?", style: TextStyle(fontSize: 20),),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Register()));
                  },
                  child: Text("Register"),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class CircleBack extends StatelessWidget {
  const CircleBack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(-1, -0.9),
          child: CustomPaint(
            painter: MyPainter(mainColor, 100),
          ),
        ),
        Align(
          alignment: Alignment(-0.3, -1.1),
          child: CustomPaint(
            painter: MyPainter(subColor, 100),
          ),
        ),
        Align(
          alignment: Alignment(1.2, 0.7),
          child: CustomPaint(
            painter: MyPainter(mainColor, 100),
          ),
        ),
        Align(
          alignment: Alignment(0.5, 1.1),
          child: CustomPaint(
            painter: MyPainter(subColor, 100),
          ),
        ),
        
      ],
    );
  }
}
