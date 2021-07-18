// ignore: unused_import
import 'package:flutter/material.dart';

class Coin {
  Coin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage_1h,
    required this.changePercentage_24h,
    required this.changePercentage_7d,
    required this.changePercentage_14d,
    required this.changePercentage_30d,
    required this.changePercentage_200d,
    required this.changePercentage_1y,
  });
  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num? changePercentage_1h;
  num? changePercentage_24h;
  num? changePercentage_7d;
  num? changePercentage_14d;
  num? changePercentage_30d;
  num? changePercentage_200d;
  num? changePercentage_1y;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'],
      price: json['current_price'],
      change: json['price_change_24h'],
      changePercentage_1h: json['price_change_percentage_1h_in_currency'],
      changePercentage_24h: json['price_change_percentage_24h'],
      changePercentage_7d: json['price_change_percentage_7d_in_currency'],
      changePercentage_14d: json['price_change_percentage_14d_in_currency'],
      changePercentage_30d: json['price_change_percentage_30d_in_currency'],
      changePercentage_200d: json['price_change_percentage_200d_in_currency'],
      changePercentage_1y: json['price_change_percentage_1y_in_currency'],
    );
  }
}

List<Coin> coinList = [];
