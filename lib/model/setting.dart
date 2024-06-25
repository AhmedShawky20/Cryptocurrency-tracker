import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;
  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}
final List<Setting> settings = [
  Setting(
    title: "E-Statements",
    route: "/",
    icon: CupertinoIcons.doc_fill,
  ),
];
