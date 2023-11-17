import 'package:flutter/material.dart';

import '../../../models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ 19.99',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: primaryColor),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
