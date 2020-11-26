import 'package:apptest/screens/find_stock.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'home.dart';
import 'package:apptest/screens/loading.dart';

void main() {
  runApp(TradeApp());
}

class TradeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trade',
      routes: {
        // '/': (context) => Loading(),
        '/': (context) => Home(),
        '/sign_up': (context) => SignUpScreen(),
        '/find_stocks': (context) => FindStock(),
      },
    );
  }
}
