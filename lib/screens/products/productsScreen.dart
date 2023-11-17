import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/customDrawer.dart';
import 'package:loja_virtual_pro/models/productManager.dart';
import 'package:loja_virtual_pro/screens/products/components/productListTile.dart';
import 'package:provider/provider.dart';

import 'components/searchDialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                                productManager.search,
                              ));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(
                              productManager.search,
                            ));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  icon: const Icon(Icons.search),
                );
              } else {
                return IconButton(
                  onPressed: () async {
                    productManager.search = '';
                  },
                  icon: const Icon(Icons.close),
                );
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: productManager.filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(productManager.filteredProducts[index]);
            },
          );
        },
      ),
    );
  }
}
