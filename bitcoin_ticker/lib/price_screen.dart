import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/currency_exchangerate_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  List<double> equivalentCurrencyRates = [0.0, 0.0, 0.0];
  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      pickerItems.add(item);
    }

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
          initialItem: currenciesList.indexOf('USD')),
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          updateUI();
        });
      },
      children: pickerItems,
      backgroundColor: Colors.lightBlue,
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        background: Colors.white.withOpacity(0.15),
      ),
    );
  }

  void getExchangeRate(int cryptoIndex) async {
    var exchangeRate = await coinData.getExchangeRates(
        cryptoList[cryptoIndex], selectedCurrency);
    if (exchangeRate != null) {
      setState(() {
        equivalentCurrencyRates[cryptoIndex] = exchangeRate['rate'];
      });
    } else
      setState(() {
        equivalentCurrencyRates[cryptoIndex] = 0.0;
      });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      updateUI();
    });
  }

  void updateUI() {
    getExchangeRate(0);
    getExchangeRate(1);
    getExchangeRate(2);
  }

  @override
  Widget build(BuildContext context) {
    List<String> exchangeRate = [];
    for (int i = 0; i < cryptoList.length; i++) {
      exchangeRate.add(equivalentCurrencyRates[i].toStringAsFixed(3));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CurrencyExchangeCard(
                  cryptoCurrency: cryptoList[0],
                  selectedCurrency: selectedCurrency,
                  exchangeRate: exchangeRate[0],
                ),
                CurrencyExchangeCard(
                  cryptoCurrency: cryptoList[1],
                  selectedCurrency: selectedCurrency,
                  exchangeRate: exchangeRate[1],
                ),
                CurrencyExchangeCard(
                  cryptoCurrency: cryptoList[2],
                  selectedCurrency: selectedCurrency,
                  exchangeRate: exchangeRate[2],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                    ),
                    onPressed: () {
                      setState(() {
                        updateUI();
                      });
                    },
                    child: Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
