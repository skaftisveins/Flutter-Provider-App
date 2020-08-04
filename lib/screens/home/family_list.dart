import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/family.dart';
import 'package:provider/provider.dart';

import 'family_tile.dart';

class FamilyList extends StatefulWidget {
  @override
  _FamilyListState createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  @override
  Widget build(BuildContext context) {
    final myFamily = Provider.of<List<Family>>(context) ?? [];
    // myFamily.forEach((family) {
    //   print(family.name);
    //   print(family.title);
    //   print(family.age);
    // });
    return ListView.builder(
      itemCount: myFamily.length,
      itemBuilder: (context, index) {
        return FamilyTile(family: myFamily[index]);
      },
    );
  }
}
