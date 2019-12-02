import 'package:flutter/material.dart';
import 'package:kitebird/models/account_model.dart';
import 'package:kitebird/modules/wallet_transactions.dart';
import 'package:kitebird/utils/temp_data.dart';
import 'package:url_launcher/url_launcher.dart';

class CardSend extends StatefulWidget {

  @override
  _CardSendState createState() => _CardSendState();
}

class _CardSendState extends State<CardSend> {
  AccountModel _theAccountModel = theAccountModel;

  bool _loading = false;

  TextEditingController _walletNo;

  TextEditingController _cardNo;
  TextEditingController _cvv;
  TextEditingController _expiryMonth;
  TextEditingController _expiryYear;
  TextEditingController _amount;
  TextEditingController _email;

  // TextEditingController _walletNumber;

  @override
  void initState() {
    super.initState();
    _walletNo = TextEditingController()..text =  _theAccountModel.wallet[0].walletAccountNo;
    // _walletNumber = TextEditingController()..text = _theAccountModel.wallet[0].walletAccountNo;
    _cardNo = TextEditingController()..text = "4242424242424242";
    _cvv = TextEditingController()..text = '812';
    _expiryMonth = TextEditingController()..text = '01';
    _expiryYear = TextEditingController()..text = '21';
    _amount = TextEditingController();
    _email = TextEditingController();
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
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _cardNo,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Card Number"
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              SizedBox(
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _cvv,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "CVV"
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _expiryMonth,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Expiry Month"
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _expiryYear,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Expiry Year"
                    ),
                  ),
                ),
              ),

            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email address"
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
                      _walletNo.clear();
                      _cardNo.clear();
                      _cvv.clear();
                      _expiryMonth.clear();
                      _expiryYear.clear();
                      _amount.clear();
                      _email.clear();
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text("Send"),
                    onPressed:
                    _walletNo.text != '' &&
                    _cardNo.text != '' &&
                    _cvv.text != '' &&
                    _expiryMonth.text != '' &&
                    _expiryYear.text != '' &&
                    _amount.text != '' &&
                    _email.text != '' ?
                     () async{
                      WalletTransacions _walletTransacions = WalletTransacions(
                        password: theUsername,
                        username: thePassword,
                        walletNo: _walletNo.text,
                      );

                      setState(() {
                        _loading = true;
                      });


                      _loading ? 
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Transacting..."),
                            content: CircularProgressIndicator(backgroundColor: Colors.white,),
                          );
                        }) : null;
                      _walletTransacions.cardWalletDeposit(
                        cardNo: _cardNo.text,
                        cvv: _cvv.text,
                        expiryMonth: _expiryMonth.text,
                        expiryYear: _expiryYear.text,
                        amount: _amount.text,
                        email: _email.text,
                      ).then((_url)async{
                        Navigator.of(context).pop();
                        setState(() {
                          _loading = false;
                        });
                        try{
                          await launch(_url);
                        } catch (e){
                          print(e);
                        }
                      });


                      } : null,
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

