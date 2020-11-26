import 'package:apptest/model/portfolio.dart';
import 'package:flutter/material.dart';
import 'model/stock.dart';
import 'package:apptest/model/user.dart';
import 'view/portfolio_item_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RamTrade'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Stock tsla;
  Stock aapl;
  Stock goog;
  Stock pltr;

  Portfolio portfolio;

  // Quantity, change today, change since start, profit/loss

  @override
  void initState() {
    super.initState();

    portfolio = buildPortfolio();
  }

  Portfolio buildPortfolio() {
    tsla = Stock(name: 'Fastly', ticker: 'FSLY');
    goog = Stock(name: 'Square', ticker: 'SQ');
    aapl = Stock(name: 'PayPal', ticker: 'PYPL');
    pltr = Stock(name: 'Palantir', ticker: 'PLTR');
    List<PortfolioItem> items = [
      PortfolioItem(stock: aapl, quantity: 5.0),
      PortfolioItem(stock: tsla, quantity: 10.4),
      PortfolioItem(stock: goog, quantity: 6.3),
      PortfolioItem(stock: pltr, quantity: 6.3),
    ];
    return Portfolio(items: items, user: User(name: 'Josh', uid: '1234'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Center(
          child: Column(
            children: portfolio.items
                .map((item) => PortfolioItemCard(item: item))
                .toList(),
          ),
        ),
      ),
    );
  }
}
