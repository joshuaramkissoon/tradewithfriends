import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter {
  final currencyFormat = NumberFormat('#,##0.00', 'en_US');

  String convertPriceToString(double price) {
    String currency = currencyFormat.format(price);
    return '\$$currency';
  }
}

class CurrencyText extends StatefulWidget {
  double amount;
  TextStyle style;

  CurrencyText({Key key, this.amount, this.style}) : super(key: key);
  @override
  _CurrencyTextState createState() => _CurrencyTextState();
}

class _CurrencyTextState extends State<CurrencyText> {
  @override
  Widget build(BuildContext context) {
    return Text(CurrencyFormatter().convertPriceToString(widget.amount),
        style: widget.style);
  }
}
