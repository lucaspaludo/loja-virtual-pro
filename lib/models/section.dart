import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document) {
    name = document['name'] as String;
    type = document['type'] as String;

    items = (document['items'] as List<dynamic>)
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }

  late String name;
  late String type;
  late List<SectionItem> items;

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
