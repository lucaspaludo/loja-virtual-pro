import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/item_size.dart';

class Product extends ChangeNotifier {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.sizes,
  });

  Product.empty()
      : id = '',
        name = '',
        description = '',
        images = [],
        sizes = [];

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    sizes = (document['sizes'] as List<dynamic>)
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference get firestoreRef => firestore.doc('products/$id');
  late String id;
  late String name;
  late String description;
  late List<String> images;
  late List<ItemSize> sizes;
  List<dynamic>? newImages;
  ItemSize? _selectedSize;

  ItemSize? get selectedSize => _selectedSize;

  set selectedSize(ItemSize? value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock!;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;

    for (final size in sizes) {
      if (size.price! < lowest && size.hasStock) {
        lowest = size.price!;
      }
    }
    return lowest;
  }

  ItemSize? findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
    };

    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImage: $newImages}';
  }
}
