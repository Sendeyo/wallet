import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kitebird/colors.dart';
import 'package:kitebird/pages/account.dart';
import 'package:kitebird/pages/mpesaSend.dart';
import 'package:kitebird/pages/walletSend.dart';
import 'package:kitebird/widgets/circle.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: 500,
            color: mainColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    color: lightColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          "assets/kitelogo.png",
                          // height: 20,
                          // width: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 150),
              child: Grid(),
            ),
          ),
        ],
      ),
    );
  }
}

class Grid extends StatelessWidget {
  Card myTile(Widget myicon, String name) {
    return Card(
      color: Colors.black.withOpacity(0.4),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: myicon,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 4,
      padding: EdgeInsets.all(8),
      children: <Widget>[
        InkWell(
          child: myTile(
              Icon(
                Icons.person,
                size: 40,
                color: Colors.blue,
              ),
              "My Account"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Account()));
          },
        ),
        InkWell(
          child: myTile(
              Icon(
                Icons.phone_android,
                size: 40,
                color: Colors.red,
              ),
              "Top Up"),
          onTap: () {
            // Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context){
                return SimpleDialog(
                  // backgroundColor: Colors.white54,
                  title: Center(child: Text("Top Up Using")),
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.green,),
                      title: Text("Mpesa"),
                      subtitle: Text("Top up wallet from your mpesa"),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MpesaSend()));
                      },
                    )
                  ],
                  
                );
              }
            );
          },
        ),
        InkWell(
          child: myTile(
              Icon(
                Icons.send,
                size: 40,
                color: Colors.orange,
              ),
              "Send to Wallet"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WalletInputs()));
          },
        ),
        InkWell(
          child: myTile(
              Transform.rotate(
                  angle: -0.7,
                  child: Icon(
                    Icons.send,
                    size: 40,
                    color: Colors.green,
                  )),
              "Send to M-pesa"),
          onTap: () {},
        ),
        InkWell(
          child: myTile(
              Icon(
                Icons.list,
                size: 40,
                color: Colors.pinkAccent,
              ),
              "Transactions"),
          onTap: () {},
        ),
        InkWell(
          child: myTile(
              Icon(
                Icons.present_to_all,
                size: 40,
                color: Colors.deepPurple
              ),
              "Billers"),
          onTap: () {},
        ),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, 130.0),
        StaggeredTile.extent(1, 100.0),
        StaggeredTile.extent(1, 100.0),
        StaggeredTile.extent(1, 100.0),
        StaggeredTile.extent(1, 130.0),
        StaggeredTile.extent(1, 100.0),
      ],
    );
  }
}
