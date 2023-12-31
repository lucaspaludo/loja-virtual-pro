import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/item_size.dart';
import 'package:loja_virtual_pro/models/product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize!.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    productId = document['pid'] as String;
    quantity = document['quantity'] as int;
    size = document['size'] as String;

    firestore.doc('products/$productId').get().then(
      (doc) => product = Product.fromDocument(doc),);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String productId;
  late int quantity;
  late String size;
  late Product product;

  ItemSize? get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }
}
