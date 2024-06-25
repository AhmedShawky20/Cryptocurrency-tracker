import 'package:Cryptocurrency/constants/captions.dart';
import 'package:flutter/material.dart';
import 'package:Cryptocurrency/constants/constanst.dart';
import 'package:Cryptocurrency/provider/card_name_provider.dart';
import 'package:provider/provider.dart';

class CardName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final defaultName =
        Provider.of<Captions>(context).getCaption('NAME_SURNAME')!.toUpperCase();
    final String name =
        Provider.of<CardNameProvider>(context).cardName.toUpperCase();

    return Text(name.isNotEmpty ? name : defaultName,
        style: name.isNotEmpty ? kNametextStyle : kDefaultNameTextStyle);
  }
}
