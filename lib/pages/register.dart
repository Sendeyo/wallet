import 'package:flutter/material.dart';
import 'package:kitebird/auth/Auth.dart';
import 'package:kitebird/colors.dart';
import 'package:kitebird/widgets/circle.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool load = false;

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  TextEditingController nameControler = TextEditingController();

  bool isSwitched = false;
  bool isChecked = false;
  int radioValue = 0;
  var backColor = Colors.white;

  void handleRadioValueChanged(int value) {
    print("Choose what identifier to use");
    setState(() {
      radioValue = value;
      switch (value) {
        case 1:
          backColor = Colors.cyanAccent;
          break;
        case 2:
          backColor = Colors.grey;
          break;
        case 3:
          backColor = Colors.lightGreen;
          break;
        default:
      }
    });
  }

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
                      InkWell(
                        child: Container(
                          color: mainColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ), //Text("Login"),
                        onTap: () {
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
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60)))),
                              ),
                              TextField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only())),
                              ),
                              TextField(
                                controller: _phoneNo,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Phone Number",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only())),
                              ),
                              // Column(
                              //   children: <Widget>[
                              //     Container(
                              //       child: Text("What Identifier will you use?"),
                              //     ),
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: <Widget>[
                              //         Radio<int>(
                              //           value: 1,
                              //           groupValue: radioValue,
                              //           onChanged: handleRadioValueChanged,
                              //           activeColor: Colors.blue,
                              //         ),
                              //         Text("National Id"),
                              //         Radio<int>(
                              //           value: 2,
                              //           groupValue: radioValue,
                              //           onChanged: handleRadioValueChanged,
                              //           activeColor: Colors.black,
                              //         ),
                              //         Text("Passport"),
                              //         Radio<int>(
                              //           value: 3,
                              //           groupValue: radioValue,
                              //           onChanged: handleRadioValueChanged,
                              //           activeColor: Colors.red,
                              //         ),
                              //         Text("KRA"),
                              //       ],
                              //     )
                              //   ],
                              // ),
                              // TextField(
                              //   // controller: _phoneNo,
                              //   keyboardType: TextInputType.number,
                              //   decoration: InputDecoration(
                              //       labelText: "Identifier Number",
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.only())),
                              // ),
                              TextField(
                                controller: _password,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only())),
                              ),
                              TextField(
                                controller: _confirm,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(60)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: CircleAvatar(
                          radius: 30,
                          child: Center(child: load ? CircularProgressIndicator(backgroundColor: Colors.white,) : Icon(Icons.arrow_forward_ios)),
                        ),
                        onTap: (){
                          onclicked();
                        },
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
  void onclicked()async{
    load = !load;
    setState(() {
      
    });

    AccountSignUp _accountSignUp = AccountSignUp(
      identifier: '123432',
      identifierType: 'NationalId',
      username: _username.text,
      email: _email.text,
      phoneNo: _phoneNo.text,
      password: _password.text
    );

    _accountSignUp.register();

        // try {
        //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('Kite Holdings001:xXcA1pGeBG'));
        //   http.Response r = await http.get("http://$url/token",headers: <String, String>{'authorization': basicAuth});
        //   print(r.statusCode);
        //   print("Working");
        //   if (r.statusCode == 200){
        //     print("this is working");
        //     String _token = json.decode(r.body)["data"]["token"].toString();
        //     Map<String, dynamic> _payload = {
        //       "identifier": "123456098",
        //       "identifierType": "NationalId",
        //       "username": _username.text,
        //       "phoneNo": _phoneNo.text,
        //       "email": _email.text,
        //       "password": _password.text
        //     };
        //     Map<String, String> _headers = {
        //       'content-type': 'application/json',
        //       'Authorization': 'Bearer ' + _token
        //     };

        //     final http.Response res = await http.post(
        //         "http://$url/accounts/consumer",
        //         headers: _headers,
        //         body: json.encode(_payload));
        //     if (res.statusCode == 200) {
        //       print(res.body);
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (BuildContext context) =>
        //                   Home()));
        //       } else {
                
        //         // User cant create account

        //       }

        //   }else{
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: Text("Error"),
        //           content: Text("Check your Values"),
        //           actions: <Widget>[
        //             FlatButton(
        //               child: Text("Close"),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //             )
        //           ],
        //         );
        //       },
        //     );
        //   }

          
        // } catch (e) {
        //   //print(e);
        //   showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: Text("Cant reach server"),
        //           content: Text("Check your internet connection"),
        //           actions: <Widget>[
        //             FlatButton(
        //               child: Text("Close"),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //             )
        //           ],
        //         );
        //       },
        //     );
            
        // }
        load = false;
        setState(() {
          
        });


        // String basicAuth = 'Basic ' + base64Encode(utf8.encode('Test 9014:2810180875'));
        // http.Response r = await http.get("http://$url/token",headers: <String, String>{
        //   'authorization': basicAuth
        //     });
        // String _token = json.decode(r.body)["data"]["token"].toString();
        // Map<String, dynamic> _payload = {
        //   "identifier": "123456098",
        //   "identifierType": "NationalId",
        //   "username": _username.text,
        //   "phoneNo": _phoneNo.text,
        //   "email": _email.text,
        //   "password": _password.text
        // };
        // Map<String, String> _headers = {
        //   'content-type': 'application/json',
        //   'Authorization': 'Bearer ' + _token
        // };

        // final http.Response res = await http.post(
        //     "http://$url/accounts/consumer",
        //     headers: _headers,
        //     body: json.encode(_payload));
        // if (res.statusCode == 200) {
        //   print(res.body);
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (BuildContext context) =>
        //               Home()));
        // } else {
        //   print("fatal error");
        // }
                            
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
