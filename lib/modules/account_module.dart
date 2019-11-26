import 'package:flutter/widgets.dart';
import 'package:kitebird/auth/Auth.dart';
import 'package:kitebird/models/account_model.dart';
import 'package:http/http.dart' as http;
import 'package:kitebird/utils/config.dart';
import 'package:kitebird/utils/process_http_request.dart';
import 'package:kitebird/utils/temp_data.dart';

/// Processes all actions on Account transactions
/// the actoins include fetching details and updating account
/// takes the sender token as the argument
class AccountModule extends ChangeNotifier{
  
  AccountModule({this.token});

  final String token;

  AccountModel _currentAccountModel;

  AccountModel get currentAccountModel => _currentAccountModel;

  set setCurrentAccountModel (AccountModel obj){
    _currentAccountModel = obj;
    theAccountModel =currentAccountModel;
    notifyListeners();
  }


  /// Fetches account details
  /// takes nothing as input
  /// returns an AccountModel
  void get fetchAccountDetails async{
    return _fetchAccountDetails();
  }

  final AccountModel _accountModel = AccountModel();

  void _fetchAccountDetails() async{

    Map<String, dynamic> _message = {
      'status': 11
    };


    final String _url = accountDetailsUrl;

    final String _accessToken = token;

    final Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
    };

    _message = await processHttpRequest( http.get(_url, headers: headers) );

    // Set CurrentAccountModel
    setCurrentAccountModel =  _accountModel.fromMap(_message['body']);

  }

}