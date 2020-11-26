// import 'dart:ffi';

import 'stock.dart';
import 'user.dart';

class PortfolioItem {
  Stock stock;
  double quantity;

  PortfolioItem({this.stock, this.quantity});
}

class Portfolio {
  User user;
  List<PortfolioItem> items;

  Portfolio({this.user, this.items});
}
