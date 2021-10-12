import 'package:flutter/material.dart';

const TextStyle kBlack_bold =
    TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black);

const TextStyle kBlack_boldtext =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

const TextStyle kText = TextStyle(fontSize: 20, color: Colors.white);

const TextStyle kBar = TextStyle(fontSize: 20, color: Colors.grey);

const TextStyle kBodyText = TextStyle(fontSize: 15, color: Colors.black);

const TextStyle kBodyTextwhite = TextStyle(fontSize: 15, color: Colors.white);

const TextStyle kbBar =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);

const TextStyle kBold =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF" + hex.toUpperCase().replaceAll("#", "");
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
