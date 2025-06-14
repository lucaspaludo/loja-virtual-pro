import 'package:flutter/material.dart';

class ItemSize {
  String name;
  num? price;
  int? stock;

  ItemSize({
    this.name = '',
    this.price = 0,
    this.stock = 0,
  });

  ItemSize.fromMap(Map<String, dynamic> map)
      : name = map['name'] as String,
        price = map['price'] as num,
        stock = map['stock'] as int;

  bool get hasStock => stock! > 0;

  ItemSize clone() {
    return ItemSize(
      name: name,
      price: price,
      stock: stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}
