import 'package:Cryptocurrency/constants/captions.dart';
import 'package:Cryptocurrency/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/NavigationScreen.dart';

class DoneButton extends StatefulWidget {
  final Function? onTap;
  final decoration;
  final textStyle;

  DoneButton({this.onTap, this.decoration, this.textStyle});

  @override
  _DoneButtonState createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  var pressed = false;

  @override
  Widget build(BuildContext context) {
    final captions = Provider.of<Captions>(context);

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationScreen(),));},

      child: AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: pressed ? 2.5 : 0),
          duration: Duration(milliseconds: 100),
          width: 95 - (pressed ? 5.0 : 0.0),
          height: 45 - (pressed ? 5.0 : 0.0),
          decoration: widget.decoration,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                Text(captions.getCaption("Done")!,style: widget.textStyle,)
              ],
            ),
          )),
    );
  }
}
