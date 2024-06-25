import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/cubit/cubit.dart';
import 'package:Cryptocurrency/cubit/state.dart';
import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
    var deposit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deposit USD',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(controller: deposit,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter amount',
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                   cubit.updateUserData(context: context,uid: FirebaseAuth.instance.currentUser!.uid,value:deposit.text );
                  },
                  child: Text('Deposit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
