import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/carManager.dart';
import 'components/cartTile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return Column(
            children: cartManager.items
                .map((cartProduct) => CartTile(cartProduct))
                .toList(),
          );
        },
      ),
    );
  }
}
