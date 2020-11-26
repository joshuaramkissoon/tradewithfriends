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
  Stock pypl;
  Stock fsly;
  Stock sq;
  Stock pltr;

  Portfolio portfolio;

  // Quantity, change today, change since start, profit/loss

  @override
  void initState() {
    super.initState();
    portfolio = buildPortfolio();
  }

  Portfolio buildPortfolio() {
    Stock baba = Stock(name: 'Alibaba', ticker: 'BABA');
    Stock goog = Stock(name: 'Alphabet Inc. Class A', ticker: 'GOOG');
    Stock nkla = Stock(name: 'Nikola Corporation', ticker: 'NKLA');
    Stock work = Stock(name: 'Slack', ticker: 'WORK');
    fsly = Stock(name: 'Fastly', ticker: 'FSLY');
    sq = Stock(name: 'Square', ticker: 'SQ');
    pypl = Stock(name: 'PayPal', ticker: 'PYPL');
    pltr = Stock(name: 'Palantir', ticker: 'PLTR');
    List<PortfolioItem> items = [
      PortfolioItem(stock: baba, quantity: 3.89, averagePrice: 256.72),
      PortfolioItem(stock: goog, quantity: 3.28, averagePrice: 1763.84),
      PortfolioItem(stock: work, quantity: 7.28, averagePrice: 29.98),
      PortfolioItem(stock: nkla, quantity: 36, averagePrice: 25.74),
      // PortfolioItem(stock: pypl, quantity: 5.0, averagePrice: 3212), //160.6
      // PortfolioItem(stock: fsly, quantity: 10.4, averagePrice: 100.00),
      // PortfolioItem(stock: sq, quantity: 6.3, averagePrice: 45.60),
      PortfolioItem(stock: pltr, quantity: 38.93, averagePrice: 17.98),
    ];
    return Portfolio(items: items, user: User(name: 'Josh', uid: '1234'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
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
