import 'dart:convert';

import 'package:http/http.dart' as http;

const kApiKey = '19E6A49D-9700-4509-9E8B-B9C0C6177FCA';
const kCoinApiRequestUrl = 'https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getExchangeRates(
      String cryptoCurrency, String selectedCurrency) async {
    var url =
        "$kCoinApiRequestUrl$cryptoCurrency/$selectedCurrency?apikey=$kApiKey";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var exchangeRates = jsonDecode(response.body);
      return exchangeRates;
    } else {
      print("error ${response.statusCode}!");
      print("Reason: ${response.reasonPhrase}");
      return null;
    }
  }
}
