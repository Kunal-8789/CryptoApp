import 'dart:convert';
import 'dart:async';

import 'package:crypto_world/coinModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'coinCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h%2C24h%2C7d%2C14d%2C30d%2C200d%2C1y'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (var i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          // ignore: unnecessary_statements
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'CRYPTOWORLD',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return CoinCard(
            name: coinList[index].name,
            symbol: coinList[index].symbol,
            imageUrl: coinList[index].imageUrl,
            price: coinList[index].price.toDouble(),
            change: coinList[index].change.toDouble(),
            changePercentage_24:
                coinList[index].changePercentage_24h?.toDouble() ?? 0,
            changePercentage_1h:
                coinList[index].changePercentage_1h?.toDouble() ?? 0,
            changePercentage_7d:
                coinList[index].changePercentage_7d?.toDouble() ?? 0,
            changePercentage_14d:
                coinList[index].changePercentage_14d?.toDouble() ?? 0,
            changePercentage_30d:
                coinList[index].changePercentage_30d?.toDouble() ?? 0,
            changePercentage_200d:
                coinList[index].changePercentage_200d?.toDouble() ?? 0,
            changePercentage_1y:
                coinList[index].changePercentage_1y?.toDouble() ?? 0,
          );
        },
      ),
    );
  }
}
