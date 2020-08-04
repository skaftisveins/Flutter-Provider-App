import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/family.dart';

class FamilyTile extends StatelessWidget {
  final Family family;

  const FamilyTile({Key key, this.family}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Colors.lightBlue[50],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/background.jpg'),
            radius: 25,
            backgroundColor: Colors.purpleAccent[family.age],
          ),
          title: Text(family.name),
          subtitle: Text('${family.title}'),
        ),
      ),
    );
  }
}
