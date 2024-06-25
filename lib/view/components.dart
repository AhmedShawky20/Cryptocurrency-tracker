import 'package:Cryptocurrency/model/news.dart';
import 'package:flutter/material.dart';

class Components extends StatelessWidget {
  Data data;
  Components(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            data.title == null ? "Untitled" : data.title.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            data.body == null ? " " : data.body.toString(),
          ),
          Divider(
            height: 20,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
