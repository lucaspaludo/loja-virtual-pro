import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/section_item.dart';

class Section {
  Section({required this.name, required this.type, required this.items});
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

  Section clone() {
    return Section(name: name, type: type, items: items);
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
