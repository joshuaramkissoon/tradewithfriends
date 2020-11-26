import 'package:flutter/material.dart';
import 'package:apptest/model/stock.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String price = 'loading';

  void fetchPrice() async {
    Stock stock = Stock(name: 'Apple', ticker: 'AAPL');
    String date = '2020-11-22 15:18:00';

    try {
      double p = await stock.getLastPrice();
      setState(() {
        price = '$p';
      });
    } catch (e) {
      setState(() {
        price = 'No price data found';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('$price'),
    );
  }
}
