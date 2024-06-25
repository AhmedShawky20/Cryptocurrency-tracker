import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'change password.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.lock_outline,
                  color: Colors.yellow,
                ),
                title: Text("Change Password"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                },
              ),
              Divider(),

              SizedBox(height: 20),
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lime.shade50,
                ),
              ),
              SwitchListTile(
                activeColor: Colors.yellow,
                contentPadding: EdgeInsets.all(0),
                value: switchValue,
                onChanged: (bool? value) {
                  setState(() {
                    switchValue = value!;
                  });
                },
                title: Text("Receive notification"),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 25,color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
