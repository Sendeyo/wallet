import 'package:flutter/material.dart';
import 'package:wallet/pages/login.dart';
import 'package:wallet/widgets/circle.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   centerTitle: true,
      //   title: Text("data"),
      // ),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                        },
                        icon: Icon(Icons.exit_to_app, size: 40,),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(image: AssetImage("asset/richard.png"))
                  //   ),
                  // ),
                  Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ClipOval(
                        // clipper: BarClipper(),
                        child: Container(
                          color: Colors.green,
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            "assets/richard.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          // child: Image.network(
                          //   "https://ca.hellomagazine.com/images/stories/0/2018/01/09/000/535/567/featured_5_3.jpg",
                          //   height: 50,
                          //   width: 50,
                          //   fit: BoxFit.cover,
                          // ),
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
                          ),
                        ),
                        Text(
                          "myemail@email.com",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ))
                ],
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
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: BarClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.26,
          color: Colors.pink,
        ),
      ),
    );
  }
}
