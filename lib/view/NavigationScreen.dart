import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/view/Profile.dart';
import 'package:Cryptocurrency/view/Settings.dart';
import 'package:Cryptocurrency/view/Wallet.dart';
import 'package:Cryptocurrency/view/home.dart';
import 'package:Cryptocurrency/view/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int pageIndex = 0;
  List<Widget> pages = [
    Home(),
    Wallet(),
    Profile(),
    Settings(),
    NewsScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getUserData(FirebaseAuth.instance.currentUser!.uid);
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

      },

  builder: (context, state) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewsScreen()));
        },
        child: Icon(
          Icons.show_chart,
          color: Colors.black,
          size: 20,
        ),
        backgroundColor: Colors.yellow,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          CupertinoIcons.home,
          CupertinoIcons.money_dollar,
          CupertinoIcons.profile_circled,
          CupertinoIcons.settings,
        ],
        gapLocation: GapLocation.center,
        inactiveColor: Colors.black.withOpacity(0.5),
        activeColor: Colors.yellow,
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 10,backgroundColor:Colors.white,
        iconSize: 25,
        rightCornerRadius: 10,
        elevation: 0,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  },
);
  }
}
