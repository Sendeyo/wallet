import 'dart:convert';

import 'package:kitebird/auth/Auth.dart';
import 'package:kitebird/utils/config.dart';
import 'package:kitebird/utils/process_http_request.dart';
import 'package:http/http.dart' as http;

/// Process all wallet transactios
/// ie; wallet to wallet, mpesa to wallet and card to wallet
/// takes the sender wallet, username and password as the arguments
class WalletTransacions {
  WalletTransacions({this.walletNo, this.password, this.username});

  final String walletNo;
  final String username;
  final String password;

  /// Performs a wallet to wallet transaction
  /// takes the recipient wallet number and amount
  /// TODO: returns status 0 if success.
  void walletToWallet({String recipientWallet, double amount})async{
    final Map<String, String> _payload = {
      "senderAccount": walletNo,
      "recipientAccount": recipientWallet,
      "amount": amount.toString(),
      "callbackUrl": null
    };

    final String _loginUrl = accountLoginUrl;
    /// Login to get the token
    final AccountLogin _accountLogin = AccountLogin(username: username, password: password);
    Map<String, dynamic> _loginBody = await _accountLogin.userLogin();

    Map<String, dynamic> _message = {
      'status': 11
    };


    final String _url = walletToWalletUrl;

    final String _accessToken = _loginBody['body'].toString();

    final Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
    };

    _message = await processHttpRequest( http.post(_url, headers: headers, body: json.encode(_payload)) );
    print(_message);
  }

  /// Performs a wallet to wallet transaction
  /// takes the recipient wallet number and amount
  /// TODO: returns status 0 if success.
  void mpesaWalletDeposit({String phoneNo, double amount})async{
    final Map<String, String> _payload = {
      	"walletAccountNo": walletNo,
        "phoneNo": phoneNo,
        "amount": amount.toString(),
        "callBackUrl": null,
        "referenceNumber": walletNo,
    };

    final String _loginUrl = accountLoginUrl;
    /// Login to get the token
    final AccountLogin _accountLogin = AccountLogin(username: username, password: password);
    Map<String, dynamic> _loginBody = await _accountLogin.userLogin();
     Map<String, dynamic> _message = {
      'status': 11
    };


    final String _url = mpesaToWalletUrl;

    final String _accessToken = _loginBody['body'].toString();

    final Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
    };

    _message = await processHttpRequest( http.post(_url, headers: headers, body: json.encode(_payload)) );

  }

  void cardWalletDeposit({
    String cardNo, 
    String cvv, 
    String expiryMonth, 
    String expiryYear, 
    String amount, 
    String email,
    })async{
      final Map<String, String> _payload = {
        "cardNo": cardNo,
        "cvv": cvv,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "currency": "KES",
        "country": "KE",
        "amount": amount,
        "email": email,
        "reference": walletNo,
        "callbackUrl": "http://18.189.117.13:2011/test"
      };

      final AccountLogin _accountLogin = AccountLogin(username: cooprateKey, password: cooprateSecret);
      Map<String, dynamic> _loginBody = await _accountLogin.cooprateLogin();
      print(_loginBody);
         print(username);
    print(password);
      Map<String, dynamic> _message = {
        'status': 11
      };


      final String _url = cardToWalletUrl;

      final String _accessToken = _loginBody['body'].toString();

      final Map<String, String> headers = {
          'content-type': 'application/json',
          'Authorization': 'Bearer $_accessToken'
      };

      _message = await processHttpRequest( http.post(_url, headers: headers, body: json.encode(_payload)) );
      print(_message);
      }


}