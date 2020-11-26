import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class FindStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Stocks'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: SearchWidget(),
    );
  }
}

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  bool _isButtonDisabled;
  bool _isSearching = false;
  List<dynamic> results;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(20),
      child: Column(children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: searchController,
                  onChanged: (val) {
                    updateSearchButton();
                  },
                  decoration:
                      InputDecoration(hintText: 'Search by name or ticker'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: RaisedButton(
                  child: _isSearching
                      ? Container(
                          margin: EdgeInsets.all(5),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.amber),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.all(10), child: Text('Search')),
                  onPressed: _isButtonDisabled ? null : search,
                ),
              ),
              SizedBox(height: 50),
              results == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: SearchResultsList(results: results)),
            ],
          ),
        )
      ]),
    );
  }

  void updateSearchButton() {
    setState(() {
      _isButtonDisabled = searchController.text.isEmpty;
    });
  }

  void search() async {
    setState(() {
      _isSearching = true;
    });
    String url =
        'https://cors-anywhere.herokuapp.com/https://ramtradeapi.herokuapp.com/symbol_search';
    Response res = await post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'query': searchController.text}));
    Map map = jsonDecode(res.body);
    List<dynamic> data = map['data'];
    print(data);
    setState(() {
      results = data;
      _isSearching = false;
    });
    // if (map['statusCode'] == 200) {
    //   return map['price'];
    // } else {
    //   throw ('No price data found');
    // }
  }
}

class SearchResultsList extends StatefulWidget {
  List<dynamic> results = [];

  SearchResultsList({Key key, this.results}) : super(key: key);

  @override
  SearchResultsListState createState() => SearchResultsListState();
}

class SearchResultsListState extends State<SearchResultsList> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: widget.results
          .map((item) => StockSearchCard(
                name: item['instrument_name'],
                ticker: item['symbol'],
                exchange: item['exchange'],
              ))
          .toList(),
    ));
  }
}

class StockSearchCard extends StatelessWidget {
  String name;
  String ticker;
  String exchange;

  StockSearchCard({Key key, this.name, this.ticker, this.exchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              '$exchange:$ticker',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }
}
