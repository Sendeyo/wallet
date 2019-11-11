import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/colors.dart';
import 'package:wallet/models/config.dart';
import 'package:wallet/widgets/circle.dart';
import 'package:http/http.dart' as http;

class MpesaSend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: <Widget>[
          // Background(),
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
                        child: Center(child: Text(""),),
                      )
                  ],
                ),
              ),

              ClipPath(
                child: Container(
                  // height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .8,
                  color: lightColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: new Inputs(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      
    );
  }
}

class Inputs extends StatelessWidget {
  
  TextEditingController _phoneNumber = TextEditingController() ..text= "254715232942";
  TextEditingController _depositAmount = TextEditingController();
  TextEditingController _walletNumber = TextEditingController() ..text = "0010000000005";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Top up wallet"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _phoneNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Mpesa Phone Number"
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _depositAmount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Ammount to Deposit"
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _walletNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Wallet Number"
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Text("clear"),
                  onPressed: (){
                    _phoneNumber.clear();
                    _depositAmount.clear();
                    _walletNumber.clear();
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.green,
                  child: Text("Send"),
                  onPressed: () async{
                    
                    String _number = _phoneNumber.text;
                    var _amount = _depositAmount.text;
                    String _wallet = _walletNumber.text;
                    if (_amount == ""){
                      showMessage();
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return SimpleDialog(
                            backgroundColor: Colors.redAccent,
                            title: Text("Error"),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("Amount cant be Empty")),
                              )
                            ],
                          );
                        }
                      );
                    }else{
                      try {
                        List<String>  numbers = [];

                        void _sendMoney() async{
                           print("Trying ...");
                        // String basicAuth = 'Basic '+base64Encode(utf8.encode('Kite Holdings001:xXcA1pGeBG'));
                        // http.Response r = await http.get("http://$ip/token",headers: <String, String>{'authorization': basicAuth});
                        // print(r.statusCode);
                        // print(r.body);

                        final Map<String, dynamic> _payload = {
                              "walletAccountNo": _walletNumber.text,
                              "phoneNo": _phoneNumber.text,
                              "amount": _depositAmount.text,
                              "callBackUrl": "http://18.189.117.13:2011/test",
                              "referenceNumber": "001100000001",
                              "transactionDesc": "transactionDesc"
                        };
                        final http.Response response = await http.post("$url/thirdParties/mpesa/depositRequest", headers: {"content-type":"application/json"}, body: json.encode(_payload));
                        print(response.body);
                        print("Tried");
                        }

                        if (numbers.contains(_number)){
                          _sendMoney();
                        }else{
                          showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            // backgroundColor: Colors.redAccent,
                            title: Text("WARNING"),
                            content: Text("This Number is not registered! \n Do you want to Continue?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                              RaisedButton(
                                child: Text("Continue", style: TextStyle(color: Colors.white),),
                                onPressed: (){
                                  _sendMoney();
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        }
                      );
                        }
                        
                      } catch (e) {
                        print(e);
                        print("failed");

                      }
                              
                    }





                  },
                ),
              ),
            ],
          ),
        )
        
      ],
    );
  }
  void showMessage(){
    print("this is it");
    
  }
}


class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: BarClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: lightColor,
        ),
      ),
    );
  }
}
