import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitebird/models/account_model.dart';
import 'package:kitebird/modules/account_module.dart';
import 'package:kitebird/utils/config.dart';
import 'package:kitebird/utils/process_http_request.dart';
import 'package:kitebird/utils/temp_data.dart';

/// Processes HTTP Basic Authorization
/// Takes username password and endpoint url as arguments
/// returns a Future map of response
class BasicAuth{

  BasicAuth({this.username, this.password, this.url});

  final String username;
  final String password;
  final String url;

  Future<Map<String, dynamic>> auth()async{
    Map<String, dynamic> _message = {
      'status': 11
    };
    final String _url = url;

    final String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    _message = await processHttpRequest( http.get(_url, headers: <String, String>{'authorization': basicAuth}) );


    return _message;

  }


}


/// Processes User and vooprate Account Login
/// Takes username password and endpoint url as arguments 
class AccountLogin{

  AccountLogin({this.username, this.password});

  final String username;
  final String password;

  /// Process user account login
  /// returns a Future of Map
  Future<Map<String, dynamic>> userLogin()async{
    final String _url = accountLoginUrl;
    final BasicAuth _basicAuth = BasicAuth(url: _url, username: username, password: password);
    Map<String, dynamic> _res = await _basicAuth.auth();

    if(_res['status'] == 0){
      _res['body'] = _res['body']['data']['token'];
      final AccountModule _accountModule = AccountModule(token: _res['body']);
      _accountModule.fetchAccountDetails;
      thePassword = password;
      theUsername = username;
    }
    return _res;
  }  
  
  /// Process cooprate account login
  /// returns a Future of Map
  Future<Map<String, dynamic>> cooprateLogin()async{
    final String _url = cooprateLoginUrl;
    final BasicAuth _basicAuth = BasicAuth(url: _url, username: username, password: password);
    Map<String, dynamic> _res = await _basicAuth.auth();

    if(_res['status'] == 0){
      _res['body'] = _res['body']['data']['token'];
    }
    
    return _res;
  }
  

  
}


/// Processes User account registration
/// Takes identifier, identifierType, username, email, phoneNo, password
class AccountSignUp{

  AccountSignUp({
    this.identifier,
    this.identifierType,
    this.username,
    this.email,
    this.phoneNo,
    this.password
  });

  final String identifier;
  final String identifierType;
  final String username;
  final String email;
  final String phoneNo;
  final String password;

  final AccountModel _accountModel = AccountModel();

  Map<String, dynamic> asMap(){
    return {
      "identifier": identifier,
      "identifierType": identifierType,
      "username": username,
      "email": email,
      "phoneNo": phoneNo,
      "password": password
    };
  }

  /// Perfome user registration
  Future<AccountModel> register() async {

    Map<String, dynamic> _message = {
      'status': 11
    };
    

    final String _loginUrl = cooprateLoginUrl;

    final AccountLogin _accountLogin = AccountLogin(username: cooprateKey, password: cooprateSecret);
    Map<String, dynamic> _loginBody = await _accountLogin.cooprateLogin();

    final String _accessToken = _loginBody['body'].toString();


    final String _url = consumerAccountUrl;

    final Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
    };
    _message = await processHttpRequest( http.post(_url, headers: headers, body: json.encode( asMap())) );
    print(_message);
    if(_message['status'] == 0){
      return _accountModel.fromMap(_message['body']);
    } else {
      return AccountModel();
    }


  }

}