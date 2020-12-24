import 'package:flutter/material.dart';
import 'package:Customer_RESERVATION/Screens/home_screen.dart';
import 'package:Customer_RESERVATION/Screens/login_screen.dart';
import 'package:Customer_RESERVATION/Screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:Customer_RESERVATION/Models/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Authentication(),
        )
      ],
      child: MaterialApp(
        title: 'Customer Reservation',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        home: LoginScreen(),
        routes: {
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}


