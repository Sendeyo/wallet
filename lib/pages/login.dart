import 'package:flutter/material.dart';
import 'package:kitebird/auth/Auth.dart';
import 'package:kitebird/colors.dart';
import 'package:kitebird/pages/home.dart';
import 'package:kitebird/pages/register.dart';
import 'package:kitebird/widgets/circle.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController accountEmail = new TextEditingController()..text = 'eddie@email.mail';

  TextEditingController accountPassword = new TextEditingController()..text = 'password';

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

                              AccountLogin _accountLogin = AccountLogin(
                                username: accountEmail.text,
                                password: accountPassword.text
                              );
                              final Map<String, dynamic> _res = await _accountLogin.userLogin();
                              
                              if (_res['status'] == 0){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                              } else if(_res['status'] == 2){
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
    var mainColor;
        return Stack(
          children: <Widget>[
        //     Align(
        //       alignment: Alignment(-1, -0.9),
        //       child: CustomPaint(
        //         painter: MyPainter(mainColor, 100),
        //   ),
        // ),
        Align(
          alignment: Alignment(-0.3, -1.1),
          child: CustomPaint(
            painter: MyPainter(subColor, 100),
          ),
        ),
        // Align(
        //   alignment: Alignment(1.2, 0.7),
        //   child: CustomPaint(
        //     painter: MyPainter(mainColor, 100),
        //   ),
        // ),
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
