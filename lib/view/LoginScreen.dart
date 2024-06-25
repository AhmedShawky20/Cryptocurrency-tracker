import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/view/ForgetPassword.dart';
import 'package:Cryptocurrency/view/NavigationScreen.dart';
import 'package:Cryptocurrency/view/SignUp.dart';
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../resourses/constants/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isVisible = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetUserDataSucssesState) {
          AppConstants.navigateToAndFinish(
              context,
              NavigationScreen());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 400),
              content: Text(
                'Login Succses ...',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/Login&Signup.png",
                            height: 200,
                            width: 200,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Welcome Please Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "PlayfairDisplay"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "example@example.com",
                              prefixIcon: Icon(Icons.email),
                              suffixIcon: Icon(Icons.account_circle),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.remove_red_eye_outlined),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: pass,
                            obscureText: isVisible,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ForgetPassword()));
                                },
                                child: Text("Forget password?"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    print(email.text);
                                    print(pass.text);
                                    if (formKey.currentState!.validate()) {


                                      AppCubit.get(context).signIN(
                                          email: email.text,
                                          password: pass.text,
                                          context: context);
                                    }
                                  },
                                  child:state is SignINLodingState ? CircularProgressIndicator() : Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("If you don't have an account"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Signup()));
                                },
                                child: Text("Register"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
