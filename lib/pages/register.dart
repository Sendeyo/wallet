import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallet/colors.dart';
import 'package:wallet/widgets/circle.dart';

import 'package:http/http.dart' as http;

import 'home.dart';

class Register extends StatelessWidget {

  TextEditingController _username = TextEditingController()..text ="max";
  TextEditingController _email = TextEditingController()..text ="m@g.com";
  TextEditingController _phoneNo = TextEditingController()..text ="254715232942";
  TextEditingController _password = TextEditingController()..text ="123445678";
  TextEditingController _confirm = TextEditingController()..text ="12345678";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Background(),
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      RaisedButton(
                        child: Text("Login"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Center(
                      child: Text(
                    "Register",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _username,
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(60))
                                  )
                                ),
                              ),
                              TextField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only()
                                  )
                                ),
                              ),
                              TextField(
                                controller: _phoneNo,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only()
                                  )
                                ),
                              ),
                              TextField(
                                controller: _password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only()
                                  )
                                ),
                              ),
                              TextField(
                                controller: _confirm,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () async {
                            String basicAuth = 'Basic '+base64Encode(utf8.encode('Test 9014:2810180875'));
                            http.Response r = await http.get("http://192.168.8.73:2011/token",headers: <String, String>{'authorization': basicAuth});
                            String _token = json.decode(r.body)["data"]["token"].toString();
                            Map<String, dynamic> _payload = {
                                "identifier": "123456098",
                                "identifierType": "NationalId",
                                "username": _username.text,
                                "phoneNo": _phoneNo.text,
                                "email": _email.text,
                                "password": _password.text
                            };
                            Map<String, String> _headers = {
                              'content-type': 'application/json',
                              'Authorization': 'Bearer ' + _token
                            };

                            final http.Response res = await http.post("http://192.168.8.73:2011/accounts/consumer", headers: _headers, body: json.encode(_payload));
                            if (res.statusCode == 200){
                              print(res.body);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                            }else{
                              print("fatal error");
                            }
                            
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(-1.1, -.8),
          child: CustomPaint(
            painter: MyPainter(mainColor, 80),
          ),
        ),
        Align(
          alignment: Alignment(-0.3, -1.1),
          child: CustomPaint(
            painter: MyPainter(mainColor, 100),
          ),
        ),
        Align(
          alignment: Alignment(0.4, 1.1),
          child: CustomPaint(
            painter: MyPainter(subColor, 80),
          ),
        ),
        Align(
          alignment: Alignment(1, 0.8),
          child: CustomPaint(
            painter: MyPainter(subColor, 100),
          ),
        ),
      ],
    );
  }
}
