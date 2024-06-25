import 'package:Cryptocurrency/util/util.dart';
import 'package:flutter/material.dart';
import 'package:Cryptocurrency/constants/constanst.dart';
import 'package:Cryptocurrency/provider/card_number_provider.dart';
import 'package:provider/provider.dart';

class CardLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String cardNumber = Provider.of<CardNumberProvider>(context).cardNumber;

    CardCompany cardCompany = detectCardCompany(cardNumber);

    return Stack(
      children: <Widget>[


      ],
    );
  }
}
