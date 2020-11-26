import 'package:flutter/material.dart';

class PortfolioOptionsCard extends StatefulWidget {
  @override
  _PortfolioOptionsCardState createState() => _PortfolioOptionsCardState();
}

class _PortfolioOptionsCardState extends State<PortfolioOptionsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AddStockButton(),
    );
  }
}

class AddStockButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Add Stock'),
      textColor: Colors.white,
      color: Colors.green[400],
      onPressed: () {
        Navigator.pushNamed(context, '/find_stocks');
      },
    );
  }
}
