// import 'dart:ffi';

import 'stock.dart';
import 'user.dart';
import 'package:apptest/view/currency_text.dart';

class PortfolioItem {
  Stock stock;
  double quantity;
  double averagePrice;

  PortfolioItem({this.stock, this.quantity, this.averagePrice});

  String getChangeString(double currentPrice) {
    // Converts change amount into a formatted currency string
    double changeAmount = getChangeAmount(currentPrice).abs();
    return CurrencyFormatter().convertPriceToString(changeAmount);
  }

  double getChangeAmount(double currentPrice) {
    return quantity * (currentPrice - averagePrice);
  }

  double getChangePercentage(double currentPrice) {
    double changePercent = (100 * (currentPrice - averagePrice) / averagePrice);
    print('${stock.ticker} $changePercent');
    return num.parse(changePercent.toStringAsFixed(1));
    // return (100 * (currentPrice - averagePrice) / averagePrice);
  }
}

class Portfolio {
  User user;
  List<PortfolioItem> items;

  Portfolio({this.user, this.items});
}
