import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const PriceCard ({required this.buttonText, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Resumo do Pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Subtotal'),
                Text('R\$: ${productsPrice.toStringAsFixed(2)}'),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'R\$: ${productsPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16,),
                  ),
                ],),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  disabledBackgroundColor:
                      Theme.of(context).primaryColor.withAlpha(100),),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
