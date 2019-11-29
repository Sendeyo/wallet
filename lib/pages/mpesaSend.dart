import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitebird/colors.dart';
import 'package:kitebird/models/account_model.dart';
import 'package:kitebird/modules/wallet_transactions.dart';
import 'package:kitebird/utils/temp_data.dart';
import 'package:kitebird/widgets/circle.dart';

class MpesaSend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: <Widget>[
          // Background(),
          SingleChildScrollView(
            child: Column(
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
            ),
          )
        ],
      ),
      
    );
  }
}

class Inputs extends StatefulWidget {

  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  AccountModel _theAccountModel = theAccountModel;

  TextEditingController _phoneNumber;

  TextEditingController _depositAmount;

  TextEditingController _walletNumber;

  @override
  void initState() {
    super.initState();
    _phoneNumber = TextEditingController()..text = _theAccountModel.address.phoneNo;
    _walletNumber = TextEditingController()..text = _theAccountModel.wallet[0].walletAccountNo;
    _depositAmount = TextEditingController();
  }

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
                        WalletTransacions _walletTransacions = WalletTransacions(
                          password: theUsername,
                          username: thePassword,
                          walletNo: _walletNumber.text,
                        );

                        _walletTransacions.mpesaWalletDeposit(
                          amount: double.parse(_depositAmount.text),
                          phoneNo: _phoneNumber.text
                        );


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
                            content: Text("Do you want to Continue?"),
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
