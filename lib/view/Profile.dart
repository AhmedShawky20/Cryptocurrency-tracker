import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {


      },
  builder: (context, state) {
        var cubit = AppCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ClipRRect(
                          
                          child: Image.asset("images/Avatar.png",height: 90,),borderRadius:BorderRadius.circular(50),),
                      

                    ],
                  ),
                ),
                const SizedBox(height:8),
                const Divider(),
                const SizedBox(height: 16),
                const Text("Profile Information",style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height/1.1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(flex:3,child: Text('Name',style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,)),
                          Expanded(flex:5,child: Text('${cubit.user_model?.name}',style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,)),
                          Expanded(child: Icon(Icons.arrow_forward_ios,size: 18,)),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 16),
                      const Text("Personal Information",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(flex:3,child: Text('Email',style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,)),
                          Expanded(flex:5,child: Text('${cubit.user_model?.email}',style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,)),
                          Expanded(child: Icon(Icons.arrow_forward_ios,size: 18,)),
                        ],
                      ),
                      SizedBox(height: 12),

                      const Divider(),
                      SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: (){
                            cubit.SignOut(context);
                          },
                          child: Text(
                              "Close Account",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
