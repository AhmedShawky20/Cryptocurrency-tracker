import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/cubit/state.dart';
import 'package:Cryptocurrency/view/LoginScreen.dart';
import '../resourses/constants/app_constants.dart';
import '../resourses/models/user_model/user_model.dart';
import '../view/Creditcardinput.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppIniteal());

  static AppCubit get(context) => BlocProvider.of(context);

  Future<void> signUpAndStoreUserData({
   required name , phone ,email,password,
    required context,
  }) async {
    emit(SignUpLodingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      String uid = userCredential.user!.uid;
      print(uid);
UserModel userModel =UserModel(uid: uid,deposit: '', email: email, password: password, name: name);
      await FirebaseFirestore.instance
          .collection('user').doc(uid)
          .set(userModel.toJson())
          .then((value) {

        emit(SignUpSucssesState());
        getUserData(uid);});

      print('User signed up and data stored successfully');
    } catch (e) {
      emit(SignUpErrorState());
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Show a Snackbar when the email is already in use

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'email-already-in-use',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'too-many-requests') {
          // Show a Snackbar when the password is incorrect

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'too-many-request',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'weak-password') {
          // Show a Snackbar when the password is too weak
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'weak-password',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else {
          // Handle other FirebaseAuth errors
          print('FirebaseAuth error during user sign-up: ${e.message}');
        }
      } else if (e is FirebaseException && e.code == 'network-request-failed') {
        // Show a Snackbar for network/connection error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                textAlign: TextAlign.center,
                'network-request-failed',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white)),
            duration: Duration(seconds: 3), // Adjust the duration as needed
          ),
        );
      } else {
        // Handle other errors
        print('Error during user sign-up: $e');
      }
      throw e;
    }
  }

  Future<void> signIN({
    required String email,
    required String password,
    required context,
  }) async {
    emit(SignINLodingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value)async {
            FirebaseFirestore.instance.collection('tokens').doc('$email').set(
                {'token': await FirebaseMessaging.instance.getToken()});
        emit(GetUserDataLodingState());
       getUserData(value.user!.uid);
     //   emit(SignINSucssesState());
      });

      print('User signed up and data stored successfully');
    } catch (e) {
      emit(SignINErrorState());
      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'user-not-found') {
          // Show a Snackbar when email is not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'المستخدم غير موجود',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'wrong-password') {
          // Show a Snackbar when the password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'الباسورد خطا',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'too-many-requests') {
          // Show a Snackbar when the password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'عدد معاملات كثيره يرجا الانتظار قليلا',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else {
          // Handle other FirebaseAuth errors
          print('FirebaseAuth error during user sign-in: ${e.message}');
        }
      } else if (e is FirebaseException && e.code == 'network-request-failed') {
        // Show a Snackbar for network/connection error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                textAlign: TextAlign.center,
                'يرجا مراجعه الاتصال الخاص بك',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white)),
            duration: Duration(seconds: 3), // Adjust the duration as needed
          ),
        );
      } else {
        // Handle other errors
        print('Error during user sign-in: $e');
      }
    }
  }

  void SignOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      print(FirebaseAuth.instance.currentUser);
      AppConstants.navigateToAndFinish(context, LoginScreen());
      emit(SignOutSucssesState());
    }).catchError((error) {
      emit(SignOutErrorState());
    });
  }

   UserModel? user_model;
  void getUserData(String uid) async {
    try {
      emit(GetUserDataLodingState());
    await FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      user_model = UserModel.fromJson(value.data()!);
      print(user_model?.name);
    });
        emit(GetUserDataSucssesState());
    } catch (error) {
      print('Error fetching user data: $error');
      emit(GetUserDataErrorState());
    }
  }
  void updateUserData({ uid, value, context}) async {
    try {
      emit(updateUserDataLodingState());
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'deposit':'$value'
    }).then((value) {
      getUserData( uid);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreditCardInputForm()));
    });
        emit(updateUserDataSucssesState());
    } catch (error) {
      print('Error fetching user data: $error');
      emit(updateUserDataErrorState());
    }
  }
}
