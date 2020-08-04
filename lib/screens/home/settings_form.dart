import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/user.dart';
import 'package:flutter_firebase_app/services/database.dart';
import 'package:flutter_firebase_app/shared/constants.dart';
import 'package:flutter_firebase_app/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> professions = [
    'Framenda Forritari',
    'Innanhús hönnuður',
    'Lyfjatæknir',
    'Smábarn'
  ];

  // form values
  String _currentName;
  String _currentTitle;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a name' : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // DropdownButton
                  DropdownButtonFormField(
                    value: _currentTitle,
                    decoration: textInputDecoration,
                    items: professions.map(
                      (profession) {
                        return DropdownMenuItem(
                          value: profession,
                          child: Text(
                            '$profession',
                            style: TextStyle(color: Colors.pink),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) => setState(() => _currentTitle = value),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Slider
                  // Slider(
                  //   value: (_currentAge ?? userData.age).toDouble(),
                  //   activeColor: Colors.purple,
                  //   inactiveColor: Colors.white,
                  //   onChanged: (value) =>
                  //       setState(() => _currentAge = value.round()),
                  //   min: 10,
                  //   max: 100,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentTitle ?? userData.title,
                            _currentAge ?? userData.age);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
