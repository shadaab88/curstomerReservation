import 'package:flutter/material.dart';
import 'package:Customer_RESERVATION/Screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:Customer_RESERVATION/Models/authentication.dart';
import 'package:Customer_RESERVATION/Screens/home_screen.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey();

  Map<String, String> _authData = {
    'email' : '',
    'password' : '',
  };

  void _showErrorDialog(String msg){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occured'),
        content: Text(msg),
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
          )
        ],
      )
    );
  }

  Future<void> _submit() async{
    if(!_formkey.currentState.validate()){
      return;
    }
    _formkey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    }catch(error){
      var errorMessge = 'Authentication faild, Please try again.';
      _showErrorDialog(errorMessge);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Login'),
          actions: [
            FlatButton(
              child: Row(
                children: [
                  Text('Signup'),
                  Icon(Icons.person_add),
                ],
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
              },
            )
          ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightGreen,
                  Colors.blue,
                ]
              )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 260.0,
                width: 300.0,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        //email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty || !value.contains('@')){
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _authData['email'] = value;
                          },
                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty || value.length<=5){
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Text(
                            'Login'
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: (){
                            _submit();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
