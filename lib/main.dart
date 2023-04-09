import 'package:flutter/material.dart';
import 'screen/bitcoin_screen.dart';

void main() {
  runApp(const BitcoinTicker());
}

class BitcoinTicker extends StatelessWidget {
  const BitcoinTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: BitCoinPickkerScreen());
  }
}
