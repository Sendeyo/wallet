import 'dart:convert';

import 'package:http/http.dart' as http;

/// Processes all HTTP requests
/// takes http request as argument
/// returns a future map
Future<Map<String, dynamic>> processHttpRequest(Future<http.Response >request)async{
  Map<String, dynamic> _message = {
      'status': 11
    };
  try{
    final http.Response _res = await request;

    if(_res.statusCode == 200){
      _message['status'] = 0;
      _message['body'] = json.decode(_res.body);
    } else
    if(_res.statusCode == 400){
      _message['status'] = 3;
      _message['body'] = json.decode(_res.body);
    } else
    if(_res.statusCode == 401){
      _message['status'] = 4;
      _message['body'] = 'Unauthorised';
    } else
    if(_res.statusCode == 404){
      _message['status'] = 5;
      _message['body'] = 'Endpoint not found';
    } else
    if(_res.statusCode == 405){
      _message['status'] = 6;
      _message['body'] = 'Method not allowed';
    } else
    if (_res.statusCode == 500){
      _message['status'] = 7;
      _message['body'] = 'Server error';        
    }


  } catch (e){
    print(e);
    _message['body'] = e;
  }

  return _message;
}