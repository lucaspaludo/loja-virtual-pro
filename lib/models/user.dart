import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  UserData(
      {required this.email,
      required this.password,
      required this.name,
      required this.id});

  UserData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    email = document['email'] as String;
  }
  late String id;
  late String name;
  late String email;
  late String password;
  late String confirmPassword;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await FirebaseFirestore.instance.collection('users').doc(id).set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
