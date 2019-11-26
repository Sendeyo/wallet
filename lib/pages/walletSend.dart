import 'package:flutter/material.dart';
import 'package:kitebird/models/account_model.dart';
import 'package:kitebird/modules/wallet_transactions.dart';
import 'package:kitebird/utils/temp_data.dart';

class WalletInputs extends StatefulWidget {

  @override
  _WalletInputsState createState() => _WalletInputsState();
}

class _WalletInputsState extends State<WalletInputs> {
  AccountModel _theAccountModel = theAccountModel;

  TextEditingController _walletNo;

  TextEditingController _depositAmount;

  // TextEditingController _walletNumber;

  @override
  void initState() {
    super.initState();
    _walletNo = TextEditingController();
    // _walletNumber = TextEditingController()..text = _theAccountModel.wallet[0].walletAccountNo;
    _depositAmount = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(theAccountModel.wallet[0].walletAccountNo);

    return Material(
      child: Column(
        children: <Widget>[
          Text("Send to Wallet"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _walletNo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Receiver wallet number"
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _walletNumber,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       hintText: "Wallet Number"
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Text("clear"),
                    onPressed: (){
                      _walletNo.clear();
                      _depositAmount.clear();
                      // _walletNumber.clear();
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text("Send"),
                    onPressed: () async{
                      
                      String _number = _walletNo.text;
                      var _amount = _depositAmount.text;
                      // String _wallet = _walletNumber.text;
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
                            
                          WalletTransacions _walletTransacions = WalletTransacions(
                            password: thePassword,
                            username: theUsername,
                            walletNo: theAccountModel.wallet[0].walletAccountNo,
                          );

                          _walletTransacions.walletToWallet(
                            amount: double.parse(_depositAmount.text),
                            recipientWallet: _walletNo.text
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
      ),
    );
  }

  void showMessage(){
    print("this is it");
    
  }
}

