import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_virtual_pro/models/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  List<Section> sections = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        sections.add(Section.fromDocument(document));
      }

      notifyListeners();
    });
  }
}
