import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/family.dart';
import 'package:flutter_firebase_app/screens/home/settings_form.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:flutter_firebase_app/services/database.dart';
import 'package:provider/provider.dart';

import 'family_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Family>>.value(
      value: DatabaseService().family,
      child: Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          title: Text('My Family'),
          backgroundColor: Colors.purple[400],
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                _auth.signOut();
                print('Signed out');
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
          ),
          child: FamilyList(),
        ),
      ),
    );
  }
}
