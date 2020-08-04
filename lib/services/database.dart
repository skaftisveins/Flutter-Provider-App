import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app/models/family.dart';
import 'package:flutter_firebase_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference familyCollection =
      Firestore.instance.collection('family');

  Future updateUserData(String name, String title, int age) async {
    return await familyCollection
        .document(uid)
        .setData({'name': name, 'title': title, 'age': age});
  }

  // family list from snapshot
  List<Family> _familyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (doc) => Family(
              name: doc.data['name'] ?? '',
              title: doc.data['title'] ?? '',
              age: doc.data['age'] ?? ''),
        )
        .toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      title: snapshot.data['title'],
      age: snapshot.data['age'],
    );
  }

  // get family stream
  Stream<List<Family>> get family {
    return familyCollection.snapshots().map(_familyListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return familyCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
