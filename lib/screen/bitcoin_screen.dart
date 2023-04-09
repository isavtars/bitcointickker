import 'package:flutter/material.dart';

import '../constance.dart';
import '../services/bitcoinmodel.dart';

class BitCoinPickkerScreen extends StatefulWidget {
  const BitCoinPickkerScreen({super.key});

  @override
  State<BitCoinPickkerScreen> createState() => _BitCoinPickkerScreenState();
}

class _BitCoinPickkerScreenState extends State<BitCoinPickkerScreen> {
  String dropedownValue = "SEK";

  int? exchangeRate;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;
  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(dropedownValue);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  //make cards

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: dropedownValue,
          value: isWaiting ? '?' : coinValues[crypto]!,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 44, 54, 59),
          title: Text("BitCoinPicker"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            makeCards(),
            Container(
              height: 150.2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 44, 54, 59),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.2),
                      topRight: Radius.circular(20.2))),
              child: DropdownButton(
                  value: dropedownValue,
                  items: currenciesList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: kdropedownText,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropedownValue = value!;
                      getData();
                    });
                  }),
            )
          ],
        ));
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color.fromARGB(255, 56, 71, 78),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
