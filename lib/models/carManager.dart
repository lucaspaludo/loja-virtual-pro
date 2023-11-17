import 'package:loja_virtual_pro/models/cartProduct.dart';
import 'package:loja_virtual_pro/models/product.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
  }

  
}
