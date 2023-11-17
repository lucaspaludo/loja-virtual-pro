import 'package:loja_virtual_pro/models/product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize!.name;
  }

  late String productId;
  late int quantity;
  late String size;
  late Product product;

}
