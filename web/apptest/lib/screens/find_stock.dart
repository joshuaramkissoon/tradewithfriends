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
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (val) {
              updateSearchButton();
            },
            decoration: InputDecoration(hintText: 'Search by name or ticker'),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            // child: Text('Search'),
            child: _isSearching
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ),
                  )
                : Container(margin: EdgeInsets.all(20), child: Text('Search')),
            onPressed: _isButtonDisabled ? null : search,
          ),
          SizedBox(height: 50),
          results == null ? Container() : SearchResultsList(results: results),
        ],
      ),
    );
  }

  void updateSearchButton() {
    setState(() {
      _isButtonDisabled = searchController.text.isEmpty;
    });
  }

  void search() async {
    setState(() {
      print('set true');
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
    setState(() {
      print('set results');
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
          .map((item) => Card(
              child:
                  ListTile(onTap: () {}, title: Text(item['instrument_name']))))
          .toList(),
    ));
    // return ListView.builder(
    //   itemCount: widget.results.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //         child: ListTile(
    //             onTap: () {},
    //             title: Text(widget.results[index]['instrument_name'])));
    //   },
    // );
  }
}
