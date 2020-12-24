import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Customer_RESERVATION/Models/http_exception.dart';


class Authentication with ChangeNotifier{
  Future<void> signUp(String email, String password) async{
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD1WLC4t74avy69mPk-_Yhu6Jl9dqnY_3M';

    try{
      final response = await http.post(url, body: json.encode({
        'email' : email,
        'password' : password,
        'returnSecureToken' : true,
      }
      ));

      final responseData = json.decode(response.body);
      if(responseData['error'] !=  null){
        throw HttpException(responseData['error']['message']);
      }
      // print(responseData);
    }catch (error){
      throw error;
    }

  }

  Future<void> logIn(String email, String password) async{
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD1WLC4t74avy69mPk-_Yhu6Jl9dqnY_3M';

    try{
      final response = await http.post(url, body: json.encode({
        'email' : email,
        'password' : password,
        'returnSecureToken' : true,
      }
      ));

      final responseData = json.decode(response.body);

      if(responseData['error'] !=  null){
        throw HttpException(responseData['error']['message']);
      }
      //print(responseData);
    } catch(error){
      throw error;
    }

  }
}