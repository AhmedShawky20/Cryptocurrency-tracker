import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class AppConstants {
  static void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));

  static void navigateToAndFinish(context, widget) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ),
          (route) => false);

  static void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }


  static Widget defButton({onTap ,context, text  ,condetion,color,width})=>      Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          width:width?? MediaQuery.sizeOf(context).width/1.4,
          height: 50,
          decoration: BoxDecoration(
              color:color ??Colors.white,
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child:condetion ? CircularProgressIndicator(color: Colors.white,): Text(
              '$text',
              style: Styles.semi_bold_15.copyWith(color:  Colors.black)  ,
            ),
          ),
        ),
      ),
    ],
  );


}
