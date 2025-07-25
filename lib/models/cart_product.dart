import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_virtual_pro/models/item_size.dart';
import 'package:loja_virtual_pro/models/product.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this.product) {
    productId = product!.id;
    quantity = 1;
    size = product!.selectedSize!.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document['pid'] as String;
    quantity = document['quantity'] as int;
    size = document['size'] as String;

    firestore.doc('products/$productId').get().then(
      (doc) {
        if (doc.exists) {
          product = Product.fromDocument(doc);
          notifyListeners();
        } else {
          debugPrint(
              'Produto $productId não encontrado no Firestore. Removendo do carrinho.');
          // product continua null
          // você pode eventualmente remover esse item do carrinho com lógica adicional
        }
      },
    );
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;
  late String productId;
  late int quantity;
  late String size;
  Product? product;

  ItemSize? get itemSize {
    if (product == null) return null;
    return product!.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {'pid': productId, 'quantity': quantity, 'size': size};
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize!.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock! >= quantity;
  }
}
