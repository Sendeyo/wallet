import 'package:flutter/material.dart';
import 'package:wallet/colors.dart';
import 'package:wallet/pages/login.dart';
import 'package:wallet/widgets/circle.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}


class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: <Widget>[
          new Background(),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                      },
                      child: Row(
                        children: <Widget>[
                          Transform.rotate(
                              angle: 3.14159, child: Icon(Icons.exit_to_app, color: subColor,)),
                          Text("Logout", style: TextStyle(color: mainColor),)
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 0.0),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (BuildContext context) => Login()));
                    //     },
                    //     icon: Transform.rotate(
                    //         angle: 3.14159,
                    //         child: Icon(
                    //           Icons.exit_to_app,
                    //           size: 40,
                    //           color: subColor,
                    //         )),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text("Logout", style: TextStyle(fontSize: 20),),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ClipOval(
                        // clipper: BarClipper(),
                        child: Container(
                          color: Colors.white24,
                          height: 100,
                          width: 100,
                          child: Image.network(
                            // "assets/richard.png",
                            "https://ca.hellomagazine.com/images/stories/0/2018/01/09/000/535/567/featured_5_3.jpg",
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email: myemail@email.com",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Phone: 0715232942",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.edit),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Edit Profile")
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    RaisedButton(
                      color: Colors.green[400],
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.share),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Share Profile")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Account Details", style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.underline),),
              ),
              
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Wallet Number: 12345678900",style: TextStyle(fontSize: 18, color: Colors.white70),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text("Wallet Balance: ",style: TextStyle(fontSize: 17, color: Colors.white70),),
                          InkWell(
                            child: showBalance ? Text("12345.00 ksh",style: TextStyle(fontSize: 20, color: Colors.white),): Text("See Balance",style: TextStyle(fontSize: 20),),
                            onTap: (){
                              showBalance = ! showBalance;
                              setState(() {
                                
                              });
                            },
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  bool showBalance = false;
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: BarClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.26,
          color: lightColor,
        ),
      ),
    );
  }
}
