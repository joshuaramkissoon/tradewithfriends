import 'package:apptest/model/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:apptest/model/stock.dart';
import 'package:apptest/view/currency_text.dart';

class StockStatistic extends StatefulWidget {
  String title;
  String value;
  Color color;

  StockStatistic({Key key, this.title, this.value, this.color})
      : super(key: key);

  @override
  _StockStatisticState createState() => _StockStatisticState();
}

class _StockStatisticState extends State<StockStatistic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(text: widget.title),
        SizedBox(
          height: 7,
        ),
        DescriptionText(text: widget.value, color: widget.color)
      ],
    );
  }
}

class TitleText extends StatefulWidget {
  String text;

  TitleText({Key key, this.text}) : super(key: key);

  @override
  _TitleTextState createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w300, color: Colors.grey[800]),
    );
  }
}

class DescriptionText extends StatefulWidget {
  String text;
  Color color;

  DescriptionText({Key key, this.text, this.color}) : super(key: key);

  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        color: widget.color == null ? Colors.black : widget.color,
      ),
    );
  }
}

class StockRow extends StatefulWidget {
  PortfolioItem item;
  double price;

  StockRow({Key key, this.item, this.price}) : super(key: key);

  @override
  _StockRowState createState() => _StockRowState();
}

class _StockRowState extends State<StockRow> {
  String price;

  void fetchPrice() async {
    try {
      double p = await widget.item.stock.getLastPrice();
      setState(() {
        print(p);
        price = '\$$p';
      });
    } catch (e) {
      print(e);
      setState(() {
        price = 'No price data found';
      });
    }
  }

  @override
  void initState() {
    // fetchPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: Text(
            widget.item.stock.name,
            style: TextStyle(fontSize: 23.0),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(
              widget.item.stock.ticker,
              style: TextStyle(
                  fontSize: 23.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        Expanded(
            child: Container(
          // color: Colors.amber,
          margin: EdgeInsets.fromLTRB(0, 10, 30, 0),
          alignment: Alignment.centerRight,
          child: widget.price == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]),
                )
              : CurrencyText(
                  amount: widget.price * widget.item.quantity,
                  style: TextStyle(fontSize: 26.0),
                ),
        )),
      ],
    );
  }
}

class PortfolioItemCard extends StatefulWidget {
  PortfolioItem item;

  PortfolioItemCard({Key key, this.item}) : super(key: key);

  @override
  _PortfolioItemCardState createState() => _PortfolioItemCardState();
}

class _PortfolioItemCardState extends State<PortfolioItemCard> {
  double price;
  void fetchPrice() async {
    try {
      double p = await widget.item.stock.getLastPrice();
      setState(() {
        price = p;
        print('${widget.item.stock.ticker} at $price');
      });
    } catch (e) {
      print(e);
      setState(() {
        print('No price data found');
      });
    }
  }

  @override
  void initState() {
    fetchPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StockRow(item: widget.item, price: price),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StockStatistic(
                      title: 'Quantity', value: '${widget.item.quantity}'),
                  price == null
                      ? StockStatistic(title: 'Last Price', value: 'Loading')
                      : StockStatistic(
                          title: 'Last Price',
                          value:
                              CurrencyFormatter().convertPriceToString(price)),
                  price == null
                      ? StockStatistic(title: 'Amount Change', value: 'Loading')
                      : StockStatistic(
                          title: 'Amount Change',
                          value: '${widget.item.getChangeString(price)}',
                          color: widget.item.getChangeAmount(price) < 0
                              ? Colors.red
                              : Colors.green),
                  price == null
                      ? StockStatistic(title: '% Change', value: 'Loading')
                      : StockStatistic(
                          title: '% Change',
                          value:
                              '${widget.item.getChangePercentage(price).abs()}%',
                          color: widget.item.getChangePercentage(price) < 0
                              ? Colors.red
                              : Colors.green),
                  // StockStatistic(title: 'Profit', value: '+\$76')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
