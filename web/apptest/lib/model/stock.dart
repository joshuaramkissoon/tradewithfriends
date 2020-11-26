import 'package:http/http.dart';
import 'dart:convert';

class Stock {
  String ticker;
  String name;
  String proxyURL = 'https://cors-anywhere.herokuapp.com/';
  String requestURL = 'https://ramtradeapi.herokuapp.com/price';
  String url =
      'https://cors-anywhere.herokuapp.com/https://ramtradeapi.herokuapp.com/price';
  String testURL = 'https://jsonplaceholder.typicode.com/todos/1';

  Stock({this.ticker, this.name});

  Future<double> getLastPrice() async {
    print('get last price $ticker');
    // Response res = await get(testURL);
    Response res = await post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'ticker': ticker}));
    Map map = jsonDecode(res.body);
    if (map['statusCode'] == 200) {
      return double.parse(map['price']);
    } else {
      throw ('No price data found');
    }
    // return 1.1;
  }

  Future<double> getPriceOnDate(String date) async {
    Response res = await post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'ticker': ticker, 'date': date}));
    Map map = jsonDecode(res.body);
    if (map['statusCode'] == 200) {
      return map['price'];
    } else {
      throw ('No price data found');
    }
  }
}
